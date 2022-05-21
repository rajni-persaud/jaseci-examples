node users;

node user {
    has id;
    has name;
    has email;
    has headline;
    has bio;
}

edge users_user {
    has id;
}