walker talker {
    
    has utterance = "";
    can use.enc_question, use.enc_answer;

    state, input_state {

        if(!utterance) {
            
            report here;

        } else {
        
            q_enc = use.enc_question(utterance);
            a_enc = use.enc_answer(here.prompts); # can take lists or single strings
            
            qa_scores = {}; #stores a map of question-answer scores
            cf_threshold = 0.2; #scores below will be discarded
            cf_max = 0; #stores the highest score
            chosen_intent = ""; #the prompt with the highest score

            for i=0 to i<(here.prompts).length by i += 1 {

                cf = vector.cosine_sim(q_enc, a_enc[i]);

                qa_scores[here.prompts[i]] = cf;

                if( cf > cf_max && cf >= cf_threshold ) {
                    cf_max = cf;
                    chosen_intent = here.prompts[i];
                }
            }

            input_state: here.input = utterance;


            response = -[transition(intent == chosen_intent)]->;
            nodeobj = {};
            message = "";

            if(!response) {
                message = "I'm not sure what you mean";
                nodeobj = here;
            } else {
                message = response[0].message;
                nodeobj = response[0];
            }  

            report {"message": message, "utterance": utterance, "intent": chosen_intent, "scores": qa_scores, "node": nodeobj};          

            disengage;
        }

    }

    closing_state {
        report {"message": here.message};
    }

    root {
        take -->[0];
    }

}