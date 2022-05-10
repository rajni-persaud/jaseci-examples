import {*} with "./graph.jac";
import {*} with "./walkers.jac";

walker init {
    root {
        #only spawn if the app_graph doesnt exist...
        take --> node::app_root else { spawn here --> graph::app_graph; }
    }
}