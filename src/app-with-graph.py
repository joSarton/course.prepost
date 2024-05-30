from dash import Dash, dcc, Output, Input  # pip install dash
import dash_bootstrap_components as dbc    # pip install dash-bootstrap-components
from plotly import graph_objs as go

import numpy as np
from math import *
# incorporate data into app


# Build your components
app = Dash(__name__, external_stylesheets=[dbc.themes.VAPOR])
mytitle = dcc.Markdown(children='My Plotter')
mygraph = dcc.Graph(figure={})
start = dcc.Input(value="-10", type="number")
end = dcc.Input(value="10", type="number")
steps = dcc.Input(value="10", type="number")
fun = dcc.Input(value="sin(x)", type="string")
dropdown_lineplotmode = dcc.Dropdown(options=['markers', 'lines', 'lines+markers'],
                        value='lines+markers',  # initial value displayed when page first loads
                        clearable=False)

# Customize your own Layout
app.layout = dbc.Container(
    [
        # Title row
        dbc.Row(
            dbc.Col(mytitle, width={"size": 6, "offset": 3}),
            justify='center'
        ),
        
        # Graph row
        dbc.Row(
            dbc.Col(mygraph, width=12)
        ),
        
        # Controls row
        dbc.Row(
            [
                dbc.Col(start, width=4),
                dbc.Col(end, width=4),
                dbc.Col(steps, width=4)
            ],
            justify='center'
        ),
        
        # Function row
        dbc.Row(
            dbc.Col(fun, width={"size": 8, "offset": 2}),
            justify='center'
        ),
        
        # Dropdown row
        dbc.Row(
            dbc.Col(dropdown_lineplotmode, width={"size": 6, "offset": 3}),
            justify='center'
        )
    ],
    fluid=True
)

# app.layout = dbc.Container([
#     dbc.Row([
#         dbc.Col([mytitle], width=6)
#     ], justify='center'),
#     dbc.Row([
#         dbc.Col([mygraph], width=12)
#     ]),
#     dbc.Row([dbc.Col([start], width=4),
#              dbc.Col([end], width=4),
#              dbc.Col([steps], width=4)], justify='center'),
#     dbc.Row([dbc.Col([fun], width=12)], justify='center'),
#     dbc.Row([
#         dbc.Col([dropdown_lineplotmode], width=6)], justify='center')], fluid=True)

# Callback allows components to interact
@app.callback(
    Output(mygraph, component_property='figure'),
    Input(dropdown_lineplotmode, component_property='value'),
    Input(start, component_property='value'),
    Input(end, component_property='value'),
    Input(steps, component_property='value'),
    Input(fun, component_property='value')
)
def update_graph(type,start,end,steps,fun):  # function arguments come from the component property of the Input
    xs=np.linspace(start=float(start),stop=float(end),num=int(steps))
    ys=[]
    for x in xs:
        ys.append(eval(fun))
    print(f"xs: {xs}, ys: {ys}")

    fig = go.Figure()
    fig.add_trace(go.Scatter(x=xs, y=ys, mode=type))
    #px.scatter(x=xs, y=ys, labels={'x': 'x', 'y': 'y'},mode=type)

    return fig  # returned objects are assigned to the component property of the Output


# Run app
if __name__=='__main__':
    app.run_server(port=8053)
