walker create_tag {
    
    has label;

    #head straight to operating context in app graph
    root: take -->[0];
    app_root: take --> node::tags;

    tags {
        #check required params
        if(!label) {
            report:status = 400;
            report "Missing required parameters";
            disengage;
        } 

        nd = spawn node::tag(label = label);

        here -[tags_tag(id = nd.info['jid'])]-> nd;
        report nd; #returns the node;   
        disengage;
    }

}


walker update_tag {
    
    has label; 

    #head straight to operating context in app graph, if not there
    root: take -->[0];
    app_root: take --> node::tags;
    tags: take -[tags_tag(id == id)]-> node::tag else: report:status = 404;

    tag {
        if(label): here.label = label;
        report here;
        disengage;
    }

}

walker delete_tag {
    
    has id;

    #head straight to operating context in app graph, if not there
    root: take -->[0];
    app_root: take --> node::tags;
    tags: take -[tags_tag(id == id)]-> node::tag else: report:status = 404;

    tag {
        report here;
        destroy here;
        disengage;
    }

}

walker get_tag {
    
    has id;

    #head straight to operating context in app graph
    root: take -->[0];
    app_root: take --> node::tags;
    tags: take -[tags_tag(id == id)]-> node::tag else: report:status = 404;

    tag {
        report here; 
        disengage;
    }

}

walker list_tag {

    has paginated = false;
    has limit = 10;
    has offset = 0;
    
    #head straight to operating context in app graph
    root: take -->[0];
    app_root: take --> node::tags;

    tags {
        report --> node::tag;
        disengage;
    }

}
