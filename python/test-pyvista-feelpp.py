import os
import pyvista as pv

# pv.start_xvfb()

# hack for vtk 9.3
filename = "/home/feelpp/feelppdb/myapp/np_1/exports/ensightgold/Exporter/Exporter.case"
new_filename = f"{filename}.tmp"

output = open(new_filename, "w")
with open(filename, "r") as input:
    Lines = input.readlines()
    for line in Lines:
        output.write(line.replace("change_coords_only", ""))

os.rename(filename, f"{filename}.orig")
os.rename(new_filename, filename)

# load "corrected" case
reader = pv.get_reader(filename)
print(reader)
mesh = reader.read()
mesh.plot(scalars="f", show_edges=True)

# restore original case
# os.rename(f"{filename}.orig", filename)
