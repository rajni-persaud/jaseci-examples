
import {*} with "./graph.jac";
import {*} with "./log/walkers.jac";
import {*} with "./user/walkers.jac";
import {*} with "./tag/walkers.jac";

walker init {

    root {
        #only spawn if the app_graph doesnt exist...
        take --> node::app_root else { spawn here --> graph::app_graph; }
    }
}