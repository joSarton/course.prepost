from dash import Dash, dcc, Output, Input  # pip install dash
import dash_bootstrap_components as dbc    # pip install dash-bootstrap-components
from math import *

# Build your components
app = Dash(__name__, external_stylesheets=[dbc.themes.SOLAR])
mytext = dcc.Markdown(children='toto ')
myinput = dbc.Input(value="3.14", type="string")
myinput1 = dbc.Input(value="sin(x)", type="string")

# Customize your own Layout
app.layout = dbc.Container([mytext, myinput, myinput1])

# Callback allows components to interact
@app.callback(
    Output(mytext, component_property='children'),
    Input(myinput, component_property='value'),
    Input(myinput1, component_property='value')
)
def update_title(input1, input2):  # function arguments come from the component property of the Input
    x=eval(input1)
    y=eval(input2)
    return f"x: {x}, y: {y}"  # returned objects are assigned to the component property of the Output


# Run app
if __name__=='__main__':
    app.run_server(port=8052)
