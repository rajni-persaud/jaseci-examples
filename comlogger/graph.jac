import {*} with "./log/graph.jac";
import {*} with "./user/graph.jac";
import {*} with "./tag/graph.jac";

node app_root;

graph app_graph {

    has anchor app_root;

    spawn {
        app_root = spawn node::app_root;
        logs = spawn app_root --> node::logs;
        users = spawn app_root --> node::users;
        tags = spawn app_root --> node::tags;
    }

}