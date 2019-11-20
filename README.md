# Anisotropic-Diffusion
This is the MATLAB code for the Anisotropic Diffusion by Perona and Malik (see below).

The function takes four parameters. Parameter that the function takes are in the following order-
AnisotropicDiffusion(image,kappa,lambda,no_itr)
where image should be an image,
kappa is the kappa value,
lambda is the lambda parameter that weighs the updated value at each iteration,
typical lambda value should be between 0 & 0.25,
and no_itr is the number of iterations (generally chosen between 2 to 10).

  @article{perona1990scale,
    title={Scale-space and edge detection using anisotropic diffusion},
    author={Perona, Pietro and Malik, Jitendra},
    journal={IEEE Transactions on pattern analysis and machine intelligence},
    volume={12},
    number={7},
    pages={629--639},
    year={1990},
    publisher={IEEE}
  }
