node state {
    has title;
    has message;
    has prompts;
}

node input_state:state {
    has input;
}

node closing_state:state;

edge transition {
    has intent;
}

graph main_graph {
    has anchor main_root;

    spawn {

        main_root = spawn node::state(
                        title = "Greeting",
                        message = "Hi there, welcome. What can we build for you today?",
                        prompts = ["website", "mobile app", "information system", "quit"] 
                    );

        closing = spawn node::closing_state(
                        title = "Thank you",
                        message = "Great! We'll be in touch."
        );

        website = spawn main_root -[transition(intent="website")]-> node::state(
                                            title = "Website",
                                            message = "What type of website would you like?",
                                            prompts = ["one pager website", "five pager website", "custom website", "back"]
                            ); 

        website -[transition(intent="back")]-> main_root;

        about_website = spawn node::input_state(
                                            title = "One Pager",
                                            message = "Describe the website you'd like to build",
                                            prompts = []
                            );
        
        website -[transition(intent="one pager website")]-> about_website;
        website -[transition(intent="five pager website")]-> about_website;
        website -[transition(intent="custom website")]-> about_website;

        about_website --> closing;
        about_website -[transition(intent="back")]-> website;
    

        mobile_app = spawn main_root -[transition(intent="mobile app")]-> node::state(
                                            title = "Mobile App",
                                            message = "What type of mobile app would you like?",
                                            prompts = ["mobile game", "social app", "custom app", "back"]
                            );

        info_system = spawn main_root -[transition(intent="information system")]-> node::state(
                                            title = "Information System",
                                            message = "Tell me about the information system you'd like",
                                            prompts = ["quit"]
                            );

        



    }
}