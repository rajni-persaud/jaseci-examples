walker create_user {
    
    has email;
    has password;

    #head straight to operating context in app graph
    root: take -->[0];
    app_root: take --> node::users;

    users {
        #check required params
        if(!email) {
            report:status = 400;
            report "Missing required parameters";
            disengage;
        } 

        account = jaseci.master_create(email, true, {'password': password, 'name': email, 'is_activated': true});

        nd = spawn node::user(id = account.info['jid'], email = email);

        here -[users_user(id = nd.info['jid'])]-> nd;
        report nd; #returns the node;   
        disengage;
    }

}
