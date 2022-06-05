node logs;
node log {
    has timestamp;
    has anchor subject;
    has body;
}

edge logs_log {
    has id;
}

edge log_tag {
    has id;
}

edge log_user {
    has id;
}