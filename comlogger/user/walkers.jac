walker create_user {
    
    has email;
    has password;

    #head straight to operating context in app graph
    root: take -->[0];
    app_root: take --> node::users;

    users {
        #check required params
        if(!email && !password) {
            report:status = 400;
            report "Missing required parameters";
            disengage;
        } 

        account = jaseci.master_create(email, true, {'password': password, 'name': email, 'is_activated': true});

        if(account.jid) {

            user_id = account['jid'];

            nd = spawn here -[ users_user(id = user_id) ] -> node::user(id = user_id, email = email);
            report nd; #returns the node;  
            
        } else {
            report account;
        }
         
        disengage;
    }

}
