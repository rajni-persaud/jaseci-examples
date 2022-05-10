walker create_log {
    
    has timestamp;
    has subject;
    has body;

    #head straight to operating context in app graph
    root: take -->[0];
    app_root: take --> node::logs;

    logs {
        nd = spawn node::log_entry(timestamp = timestamp, subject = subject, body = body);

        here -[log_link(id = nd.info['jid'])]-> nd;
        #here -[log_link(id = &nd)]-> nd;
        report nd; #returns the node;   
        disengage;
    }

}

walker get_log {
    
    has id;

    #head straight to operating context in app graph
    root: take -->[0];
    app_root: take --> node::logs;

    logs {
        report -[log_link(id == id)]-> node::log_entry;
        disengage;
    }

}
