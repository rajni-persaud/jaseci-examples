walker create_log {
    
    has timestamp;
    has subject;
    has body;
    has tags;
    has user;

    #head straight to operating context in app graph
    root: take -->[0];
    app_root: take --> node::logs;

    logs {
        
        if(!subject || !body) {
            report.status = 400;
            report "Missing required parameters";
            disengage;
        } 

        nd = spawn node::log(subject = subject, body = body);

        #use time_now() if none provided
        if(!timestamp): timestamp = std.time_now();
        nd.timestamp = timestamp;
        
        here -[logs_log(id = nd.info['jid'])]-> nd;
        #here -[log_link(id = &nd)]-> nd; is another way to do the above

        #expecting an array of tag IDs to associate
        if(tags && tags.length) {
            for tag_id in tags {
                nd -[log_tag(id = tag_id)]-> *tag_id; # *tag_id will resolve to the tag node obj based on id in tag_id variable 
            } 
        }
        #expecting user id.. map to node
        if(user): nd -[log_user(id = user)]-> *user;
        
        report nd; #returns the node;   
        disengage;
    }

}


walker update_log {
    
    has id;
    has timestamp;
    has subject;
    has body; 

    #head straight to operating context in app graph, if not there
    root: take -->[0];
    app_root: take --> node::logs;
    logs: take -[logs_log(id == id)]-> node::log else: report.status = 404;

    log {
        
        if(timestamp): here.timestamp = timestamp;
        if(subject): here.subject = subject;
        if(body): here.body = body;

        #expecting an array of tag IDs to associate
        if(tags && tags.length) {
            for tag_id in tags {
                here -[log_tag(id = tag_id)]-> *tag_id; # *tag_id will resolve to the tag node obj based on id in tag_id variable 
            } 
        }
        

        report here;

        disengage;
    }

}

walker delete_log {
    
    has id;

    #head straight to operating context in app graph, if not there
    root: take -->[0];
    app_root: take --> node::logs;
    logs: take -[logs_log(id == id)]-> node::log else: report.status = 404;

    log {
        report here;
        destroy here;
        disengage;
    }

}

walker get_log {
    
    has id;

    #head straight to operating context in app graph
    root: take -->[0];
    app_root: take --> node::logs;
    logs: take -[logs_log(id == id)]-> node::log else: report.status = 404;

    log {
        report here;
        disengage;
    }

}

walker list_log {

    has paginated = false;
    has limit = 10;
    has offset = 0;
    
    #head straight to operating context in app graph
    root: take -->[0];
    app_root: take --> node::logs;

    logs {
        report --> node::log;
        disengage;
    }

}
