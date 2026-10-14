# Implementation notes

These notes describe findings from a static review of the source supplied in `progetto.zip`. They are separate from the results reported in the original presentation. The original MATLAB/Simulink files have been preserved in this repository; the small `skew.m` helper was added when packaging it.

The preparation environment did not contain MATLAB/Simulink. No end-to-end simulation or rerun of the original experiments has been performed.

## Confirmed source-level findings

| Location | Finding | Practical relevance |
| --- | --- | --- |
| `ControlA/controller/MATLAB Function3` | The full mass/Coriolis/damping compensation command is commented out; the active command is `g_RB_star + 170*s`. | The saved controller differs from the complete formulation in slide 8. |
| `circularpath.m` | The constant-speed branch assigns `sdot(i)=sdotdot_c` instead of `sdot_c`. | The returned velocity is not the derivative of the position. With the supplied 16 s arcs it is about 0.27095 m/s instead of 1.44507 m/s during cruise. |
| `circularpath.m` | The acceleration expression distributes `1/rho` inconsistently between the radial and tangential components. | The supplied acceleration reference also needs correction. |
| `ControlA` matrix-building functions | The final angular-map element is `-cos(theta)*sin(phi)`, while the other functions use `cos(theta)*cos(phi)`. | At zero roll and pitch, the former map has diagonal `[1,1,0]`, incorrectly suppressing the yaw-rate contribution to the construction of `C` and `D`. |
| `ControlA` controller and plant functions | Several entries of `R_dot`, and element `(3,3)` of `Jk0_dot`, do not match derivatives of the matrices written in the source. | The transformed dynamic terms require rederivation. |
| `ControlA` coordinate transformation | The source uses `nu=A*eta_dot` but forms `M_star=inv(A)'*M*inv(A)`. | For that velocity mapping, the energy-consistent mass transformation is `A'*M*A`; the frame convention needs to be unified throughout the dynamics. |
| Restoring-force functions in both models | The torque expression pairs `r_b` with the gravitational force and `r_g` with buoyancy. | If the names denote the buoyancy and gravity centers respectively, the force/moment-arm association needs correction. |
| `Fermo.m`, `trajectory_q_8.m` | `xd_ddot` contains `p_edot` instead of `p_eddot` for translation. | This output is incorrect, although the saved `ControlE` model does not consume `xd_ddot`. |
| `ControlE/controller` | The reference velocity generated in inertial coordinates is subtracted directly from body-frame `ni`. | Tracking feedback needs both velocities expressed in the same frame. |
| `VidControlA.m` | Components 4 and 6 are assigned to yaw and roll respectively, while the dynamics order them as roll and yaw. | The displayed attitude differs from the simulated attitude. |

For an arc parameterized by `beta=(s-si)/rho`, a consistent local acceleration is

$$\ddot p=\frac{\dot s^2}{\rho}[-\cos\beta,-\sin\beta,0]+\ddot s[-\sin\beta,\cos\beta,0].$$

Numerical checks of the stored matrix formulas identified derivative inconsistencies at `R_dot(2,1)`, `(2,2)`, `(2,3)`, `(3,1)`, `(3,2)` and `Jk0_dot(3,3)` in `ControlA`.

## Items requiring a consistent convention

- The adaptive law shown in slide 11 has a negative sign and an inverse gain; the stored function uses `+16*Phi'*s_v`. Error definitions must be checked together with the control law before drawing a stability conclusion from this difference.
- `ControlE` constructs `C` and `D` from velocity minus the stored current vector, but multiplies those matrices by `ni=J_e*etha_dot` in the acceleration function. The intended relative-flow formulation and frame of the current need to be made explicit.
- Some built-in block values, including an intermediate Gain and the signs of a Sum block in `ControlE`, are not explicitly serialized in the inspected XML. Their default values should be confirmed in Simulink.
- The quaternion feedback does not remove the Euler-angle singularity from the plant integration. The angular rate map remains singular at pitch of plus or minus 90 degrees.

## Interpreting results

The included figures come from the original presentation. Their exact generating configurations are not recorded alongside the images, and the saved models use different yaw references and disturbances. No RMSE, control-energy or quantitative ranking is asserted.

The final three components of `y_tilde` in `ControlE` are the vector part of a quaternion error. The orientation-error legends used by `plotE.m` should not be interpreted as three direct Euler-angle errors in radians.

The adaptive regressor is 6-by-9 and has instantaneous rank 6. An estimate settling in a regulation plot does not by itself prove unique identification of nine physical parameters.

The non-adaptive comparison is documented in slide 16, but the source archive does not define a separate switch or reproducible experiment configuration for it. The adaptive estimate integrator is connected in the supplied `ControlE` model.

## Suggested revalidation order

1. Correct trajectory derivatives and handle zero-length path segments and zero/180-degree relative rotations.
2. Use a single set of kinematic/frame conventions and correct the restoring-force moment arms.
3. Select and document the active `ControlA` law; check the adaptive controller's error and sign conventions.
4. Rerun regulation and tracking with matching references, disturbances and initial conditions.
5. Save the numerical simulation outputs with their configurations, then regenerate figures and compute tracking metrics.
