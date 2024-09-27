import meshio
msh = meshio.read('Bitter.msh')
meshio.write("Bitter.vtk",msh)

