 create sequence hibernate_sequence start 1 increment 1;

    create table comments (
       id int8 not null,
        commentable_id int8 not null,
        context varchar(255) not null,
        parent_id int8,
        commentable_type varchar(255) not null,
        user_id int8,
        primary key (id)
    );

    create table database_change_log_lock (
       id int8 not null,
        lock_granted timestamp,
        locked boolean not null,
        locked_by varchar(255),
        primary key (id)
    );

    create table highlights (
       id int8 not null,
        url_details int8,
        user_id int8,
        primary key (id)
    );

    create table join_request (
       id int8 not null,
        status varchar(255),
        uid varchar(255),
        studio_id int8,
        user_id int8,
        primary key (id)
    );

    create table notifications (
       id int8 not null,
        action_url varchar(255),
        context varchar(255),
        entity_id int8,
        is_email BOOLEAN NOT NULL,
        is_notification BOOLEAN NOT NULL,
        entity_type varchar(255),
        uid varchar(255),
        primary key (id)
    );

    create table project_user (
       Id int8 not null,
        user_id int8 generated by default as identity,
        project_id int8 not null,
        primary key (user_id, project_id)
    );

    create table projects (
       id int8 not null,
        project_description varchar(255),
        project_name varchar(255),
        worked_for varchar(255),
        primary key (id)
    );

    create table roles (
       id int8 not null,
        role_description varchar(255),
        role_name varchar(255),
        primary key (id)
    );

    create table roles_skills (
       role_id int8 not null,
        skill_id int8 not null,
        primary key (role_id, skill_id)
    );

    create table schema_migration (
       id int8 generated by default as identity,
        version varchar(255) not null,
        primary key (id)
    );

    create table skills (
       id int8 not null,
        skill_description varchar(255),
        skill_name varchar(255),
        primary key (id)
    );

    create table skills_sources (
       skill_id int8 not null,
        source_id int8 not null,
        primary key (skill_id, source_id)
    );

    create table sources (
       id int8 not null,
        source_name varchar(255),
        primary key (id)
    );

    create table states (
       id int8 not null,
        name varchar(255),
        position int8 not null,
        studio_id int8,
        primary key (id)
    );

    create table stories (
       id int8 not null,
        description varchar(255),
        due_date timestamp,
        name varchar(255),
        position int8,
        remarks varchar(255),
        start_date timestamp,
        state_id int8 not null,
        primary key (id)
    );

    create table studio_assets (
       id int8 not null,
        asset_file_content_type varchar(128),
        asset_file_name varchar(64),
        asset_file_size INT DEFAULT 0,
        asset_file_updated_at timestamp,
        asset_file_url varchar(1024),
        asset_type VARCHAR(255) COMMENT 'document or image or audio or video.',
        bucket_name varchar(512),
        context varchar(255),
        is_deleted BOOLEAN DEFAULT FALSE,
        is_published BOOLEAN DEFAULT FALSE,
        is_uploaded BOOLEAN DEFAULT FALSE,
        is_uploading BOOLEAN DEFAULT FALSE,
        name varchar(255),
        parent_id int4,
        script_locked_at timestamp,
        script_locked_by int4,
        uid varchar(255),
        version INT DEFAULT 1,
        studio_id int8,
        user_id int8,
        primary key (id)
    );

    create table studio_user_requests (
       studio_id int8 not null,
        user_id int8 not null,
        primary key (user_id, studio_id)
    );

    create table studios (
       id int8 not null,
        description varchar(255),
        is_community INT DEFAULT 1,
        name varchar(255),
        registration BOOLEAN DEFAULT FALSE,
        uid varchar(255),
        visibility BOOLEAN DEFAULT TRUE,
        primary key (id)
    );

    create table tags (
       id int8 not null,
        name varchar(128),
        primary key (id)
    );

    create table tasks (
       id BIGINT NOT NULL not null,
        description varchar(255),
        is_done BOOLEAN NOT NULL,
        story_id int8,
        primary key (id)
    );

    create table tenant_users (
       user_id int8 not null,
        tenant_id int8 not null,
        primary key (user_id, tenant_id)
    );

    create table tenants (
       id int8 not null,
        entity_id int4,
        entity_type varchar(255),
        subdomain varchar(255),
        primary key (id)
    );

    create table user_notification (
       user_id int8 not null,
        notification_id int8 not null,
        primary key (user_id, notification_id)
    );

    create table user_skills (
       user_id int8 not null,
        skills_id int8 not null,
        skill_id int8 not null,
        primary key (user_id, skill_id)
    );

    create table users (
       id int8 not null,
        current_sign_in timestamp,
        current_sign_ip varchar(255),
        email varchar(255) not null,
        first_name varchar(255),
        last_name varchar(255),
        last_sign_in timestamp,
        last_sign_ip varchar(255),
        password varchar(255),
        phone_number varchar(255),
        photo_url varchar(255),
        provider_id int8,
        provider_token varchar(255) not null,
        reset_password_token varchar(255),
        session_token varchar(255),
        sign_in_count int4,
        primary key (id)
    );

    create table users_role (
       user_id int8 not null,
        role_id int8 not null,
        primary key (role_id, user_id)
    );

    alter table if exists project_user 
       add constraint UK_ptwhmsh2vocln8sffhyvr2ohm unique (project_id);

    alter table if exists users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table if exists comments 
       add constraint FK8omq0tc18jd43bu5tjh6jvraq 
       foreign key (user_id) 
       references users;

    alter table if exists join_request 
       add constraint FKofei8bipotvgv42scq2lsbdpd 
       foreign key (studio_id) 
       references studios;

    alter table if exists join_request 
       add constraint FKp89moml11gm189idwqk8h5av1 
       foreign key (user_id) 
       references users;

    alter table if exists project_user 
       add constraint FKfscw5rga2yu389e705x9wg6kb 
       foreign key (user_id) 
       references users;

    alter table if exists project_user 
       add constraint FKjgd8xdmxso8druud6ru4so0qs 
       foreign key (project_id) 
       references users;

    alter table if exists roles_skills 
       add constraint FKr97tcjvqyw2ynbxfjub4l5stq 
       foreign key (skill_id) 
       references roles;

    alter table if exists roles_skills 
       add constraint FKslf8xwrti4nxhl91u84kyg4s5 
       foreign key (role_id) 
       references skills;

    alter table if exists skills_sources 
       add constraint FKogkr415vg422lg2bfysq19vfb 
       foreign key (source_id) 
       references skills;

    alter table if exists skills_sources 
       add constraint FKg66saagtov0c8bsq3gvmbnvlb 
       foreign key (skill_id) 
       references sources;

    alter table if exists states 
       add constraint FK923ccnn5bnnga4hcey2u5kua4 
       foreign key (studio_id) 
       references studios;

    alter table if exists stories 
       add constraint FKf3rmkukvxvgphqqgf5hxpuhec 
       foreign key (state_id) 
       references states;

    alter table if exists studio_assets 
       add constraint FKgt44ux1rlaobxi5jfu5aff8x6 
       foreign key (studio_id) 
       references studios;

    alter table if exists studio_assets 
       add constraint FKmyab5f80337m35as6sx0qr28s 
       foreign key (user_id) 
       references users;

    alter table if exists studio_user_requests 
       add constraint FKly23kybo94tg4r2w895cgl3de 
       foreign key (user_id) 
       references studios;

    alter table if exists studio_user_requests 
       add constraint FKahxh11a25w9mr8snuxhj1t50v 
       foreign key (studio_id) 
       references users;

    alter table if exists tasks 
       add constraint FK4htjkrms846vp5xcb3vlvvucn 
       foreign key (story_id) 
       references stories;

    alter table if exists tenant_users 
       add constraint FKl6ca3r58xap9n74vt6yfw6pkv 
       foreign key (tenant_id) 
       references users;

    alter table if exists tenant_users 
       add constraint FK3fl99buvnfjb2dpu5ngu2pwju 
       foreign key (user_id) 
       references tenants;

    alter table if exists user_notification 
       add constraint FKp137d22f65l9kjbqjgfb37oy 
       foreign key (notification_id) 
       references notifications;

    alter table if exists user_notification 
       add constraint FKc2d7aih8weit50jlu4q57cvs 
       foreign key (user_id) 
       references users;

    alter table if exists user_skills 
       add constraint FKlp19pfb2d1f0dmhauxnhhsn35 
       foreign key (skills_id) 
       references skills;

    alter table if exists user_skills 
       add constraint FKro13if9r7fwkr5115715127ai 
       foreign key (user_id) 
       references users;

    alter table if exists user_skills 
       add constraint FKowo5tmvt3qp6en4bea92mgdnx 
       foreign key (skill_id) 
       references users;

    alter table if exists users_role 
       add constraint FKeejqlb4gq1av9540jg66ju2pi 
       foreign key (role_id) 
       references roles;

    alter table if exists users_role 
       add constraint FKqpe36jsen4rslwfx5i6dj2fy8 
       foreign key (user_id) 
       references users;