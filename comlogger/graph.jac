node app_root;

node users;
node user {
    has name;
    has email;
    has headline;
    has bio;
}

node logs;
node log_entry {
    has timestamp;
    has subject;
    has body;
}

edge log_link {
    has id;
}

node tags;
node tag {
    has label;
}

graph app_graph {

    has anchor app_root;

    spawn {
        app_root = spawn node::app_root;
        users = spawn app_root --> node::users;
        logs = spawn app_root --> node::logs;
        tags = spawn app_root --> node::tags;
    }

}