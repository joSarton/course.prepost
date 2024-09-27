import feelpp.core as fppc

app = fppc.Environment(["myapp"], config=fppc.globalRepository("myapp"))

import os

print(f"pwd: {os.getcwd()}")

geo = fppc.download(
    "github:{repo:feelpp,path:feelpp/quickstart/laplacian/cases/feelpp2d/feelpp2d.geo}",
    worldComm=app.worldCommPtr(),
)[0]
print("geo file: {}".format(geo))
mesh = fppc.load(fppc.mesh(dim=2, realdim=2), geo, 0.1)

Xh = fppc.functionSpace(mesh=mesh, space="Pchv")
f = Xh.element()
f.on(
    range=fppc.elements(mesh),
    expr=fppc.expr("{sin(pi*x)*sin(pi*y),cos(pi*x)*cos(pi*y)}:x:y", row=2, col=1),
)
e = fppc.exporter(mesh=mesh)
e.add("f", f)
e.save()
