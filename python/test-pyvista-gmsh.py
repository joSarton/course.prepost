import pyvista as pv

# uncomment the next line, if you cannot get the image
# pv.start_xvfb()
# pv.set_jupyter_backend("static")

mesh = pv.read('Bitter.msh')
mesh.plot(
    scalars='gmsh:physical',
    show_edges=True,
    interactive=False,
    cpos="xy",
    show_scalar_bar=False,
)
