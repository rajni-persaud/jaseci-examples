walker talker {
    
    has utterance;

    state, input_state {
        
        std.out(here.message, here.prompts);

        utterance = std.input("> ");

        if(utterance == "quit") {
            disengage;
        } 

        input_state: here.input = utterance;

        take -[transition(intent == utterance)]-> else {

            input_state {
                report here.input;
                take --> node::closing_state;
            } 
            state: take here;
        }
    }

    closing_state {
        std.out(here.message);
    }
}