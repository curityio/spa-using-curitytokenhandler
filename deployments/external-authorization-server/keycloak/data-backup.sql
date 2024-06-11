--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3 (Debian 16.3-1.pgdg120+1)
-- Dumped by pg_dump version 16.3 (Debian 16.3-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64)
);


ALTER TABLE public.admin_event_entity OWNER TO postgres;

--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO postgres;

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO postgres;

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO postgres;

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO postgres;

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO postgres;

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO postgres;

--
-- Name: client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO postgres;

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.client_attributes OWNER TO postgres;

--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO postgres;

--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO postgres;

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO postgres;

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO postgres;

--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO postgres;

--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO postgres;

--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO postgres;

--
-- Name: client_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    redirect_uri character varying(255),
    state character varying(255),
    "timestamp" integer,
    session_id character varying(36),
    auth_method character varying(255),
    realm_id character varying(255),
    auth_user_id character varying(36),
    current_action character varying(36)
);


ALTER TABLE public.client_session OWNER TO postgres;

--
-- Name: client_session_auth_status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_auth_status OWNER TO postgres;

--
-- Name: client_session_note; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_note OWNER TO postgres;

--
-- Name: client_session_prot_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_prot_mapper OWNER TO postgres;

--
-- Name: client_session_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_role OWNER TO postgres;

--
-- Name: client_user_session_note; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_user_session_note OWNER TO postgres;

--
-- Name: component; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO postgres;

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.component_config OWNER TO postgres;

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO postgres;

--
-- Name: credential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.credential OWNER TO postgres;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO postgres;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO postgres;

--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO postgres;

--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255),
    details_json_long_value text
);


ALTER TABLE public.event_entity OWNER TO postgres;

--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024),
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


ALTER TABLE public.fed_user_attribute OWNER TO postgres;

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO postgres;

--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO postgres;

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.fed_user_credential OWNER TO postgres;

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO postgres;

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO postgres;

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO postgres;

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO postgres;

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO postgres;

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO postgres;

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO postgres;

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL
);


ALTER TABLE public.identity_provider OWNER TO postgres;

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO postgres;

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO postgres;

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO postgres;

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36)
);


ALTER TABLE public.keycloak_group OWNER TO postgres;

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO postgres;

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO postgres;

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL
);


ALTER TABLE public.offline_client_session OWNER TO postgres;

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.offline_user_session OWNER TO postgres;

--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO postgres;

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO postgres;

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO postgres;

--
-- Name: realm; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


ALTER TABLE public.realm OWNER TO postgres;

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE public.realm_attribute OWNER TO postgres;

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO postgres;

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO postgres;

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO postgres;

--
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE public.realm_localizations OWNER TO postgres;

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO postgres;

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO postgres;

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO postgres;

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO postgres;

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO postgres;

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO postgres;

--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO postgres;

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO postgres;

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO postgres;

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode smallint NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO postgres;

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO postgres;

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy smallint,
    logic smallint,
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE public.resource_server_policy OWNER TO postgres;

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO postgres;

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO postgres;

--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO postgres;

--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO postgres;

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO postgres;

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO postgres;

--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


ALTER TABLE public.user_attribute OWNER TO postgres;

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO postgres;

--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO postgres;

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO postgres;

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO postgres;

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO postgres;

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO postgres;

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO postgres;

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO postgres;

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO postgres;

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO postgres;

--
-- Name: user_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_session (
    id character varying(36) NOT NULL,
    auth_method character varying(255),
    ip_address character varying(255),
    last_session_refresh integer,
    login_username character varying(255),
    realm_id character varying(255),
    remember_me boolean DEFAULT false NOT NULL,
    started integer,
    user_id character varying(255),
    user_session_state integer,
    broker_session_id character varying(255),
    broker_user_id character varying(255)
);


ALTER TABLE public.user_session OWNER TO postgres;

--
-- Name: user_session_note; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


ALTER TABLE public.user_session_note OWNER TO postgres;

--
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


ALTER TABLE public.username_login_failure OWNER TO postgres;

--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO postgres;

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
894a9209-c810-4040-9baf-f3609ce03af4	\N	auth-cookie	7aa9c96c-04c3-424e-8bf5-94873e7e3275	994f8ab2-6b42-49b5-9dba-378f346d9f25	2	10	f	\N	\N
9263c0ff-1ea0-4658-ac20-a62d46ebe78d	\N	auth-spnego	7aa9c96c-04c3-424e-8bf5-94873e7e3275	994f8ab2-6b42-49b5-9dba-378f346d9f25	3	20	f	\N	\N
9866952a-7868-4e7a-8b76-819c09006516	\N	identity-provider-redirector	7aa9c96c-04c3-424e-8bf5-94873e7e3275	994f8ab2-6b42-49b5-9dba-378f346d9f25	2	25	f	\N	\N
d530dd32-00ea-472d-9a93-2666fc2046e2	\N	\N	7aa9c96c-04c3-424e-8bf5-94873e7e3275	994f8ab2-6b42-49b5-9dba-378f346d9f25	2	30	t	23f49178-1d19-40f7-b5a6-eeeba49d008e	\N
684668da-f88d-4e8b-b374-9ff26866745c	\N	auth-username-password-form	7aa9c96c-04c3-424e-8bf5-94873e7e3275	23f49178-1d19-40f7-b5a6-eeeba49d008e	0	10	f	\N	\N
3809101a-883f-4451-8508-658a9693b258	\N	\N	7aa9c96c-04c3-424e-8bf5-94873e7e3275	23f49178-1d19-40f7-b5a6-eeeba49d008e	1	20	t	4e532fd4-4c93-45d5-ac36-dc8606378fed	\N
436670ef-a376-4060-8eea-8a93ce6df852	\N	conditional-user-configured	7aa9c96c-04c3-424e-8bf5-94873e7e3275	4e532fd4-4c93-45d5-ac36-dc8606378fed	0	10	f	\N	\N
b12c2677-e6b3-48ba-8049-b8edd508c175	\N	auth-otp-form	7aa9c96c-04c3-424e-8bf5-94873e7e3275	4e532fd4-4c93-45d5-ac36-dc8606378fed	0	20	f	\N	\N
444669ac-7f0f-4201-a3a5-f19bf12e7fc2	\N	direct-grant-validate-username	7aa9c96c-04c3-424e-8bf5-94873e7e3275	a30e6232-d7bf-4925-8fa6-ded509a6b943	0	10	f	\N	\N
aeeae4da-dfae-44fc-acf7-4eb403da852e	\N	direct-grant-validate-password	7aa9c96c-04c3-424e-8bf5-94873e7e3275	a30e6232-d7bf-4925-8fa6-ded509a6b943	0	20	f	\N	\N
890af225-bf30-4de3-83f4-196882fafd21	\N	\N	7aa9c96c-04c3-424e-8bf5-94873e7e3275	a30e6232-d7bf-4925-8fa6-ded509a6b943	1	30	t	d25e1291-152f-4dfb-891c-ccdb39431ca3	\N
ba757b93-04b4-4f8c-a3ad-3141d4967c82	\N	conditional-user-configured	7aa9c96c-04c3-424e-8bf5-94873e7e3275	d25e1291-152f-4dfb-891c-ccdb39431ca3	0	10	f	\N	\N
9eb48d0f-0b93-41b7-b5b7-58eb4f972bb2	\N	direct-grant-validate-otp	7aa9c96c-04c3-424e-8bf5-94873e7e3275	d25e1291-152f-4dfb-891c-ccdb39431ca3	0	20	f	\N	\N
987f99f3-9bfb-47e4-abde-f02ceee38222	\N	registration-page-form	7aa9c96c-04c3-424e-8bf5-94873e7e3275	bf29764d-ab50-49be-93e6-6da303c8c1a3	0	10	t	4b448feb-b074-4bfb-9f4b-df987bc0a817	\N
40f8f6ae-876e-4706-932c-46bd43560a23	\N	registration-user-creation	7aa9c96c-04c3-424e-8bf5-94873e7e3275	4b448feb-b074-4bfb-9f4b-df987bc0a817	0	20	f	\N	\N
29fba26d-5762-4344-a361-6a8082eb1f58	\N	registration-password-action	7aa9c96c-04c3-424e-8bf5-94873e7e3275	4b448feb-b074-4bfb-9f4b-df987bc0a817	0	50	f	\N	\N
44e910bb-5b97-49ca-8f76-608a10fc566e	\N	registration-recaptcha-action	7aa9c96c-04c3-424e-8bf5-94873e7e3275	4b448feb-b074-4bfb-9f4b-df987bc0a817	3	60	f	\N	\N
116b2911-f1f9-4cae-a5c6-48c365af1672	\N	reset-credentials-choose-user	7aa9c96c-04c3-424e-8bf5-94873e7e3275	4ad402c9-e873-4196-a6bd-006ae9a99aac	0	10	f	\N	\N
ccfefb02-c228-454d-9189-c1f95027de98	\N	reset-credential-email	7aa9c96c-04c3-424e-8bf5-94873e7e3275	4ad402c9-e873-4196-a6bd-006ae9a99aac	0	20	f	\N	\N
fae0a8e0-7b0b-4553-995a-434825e9490e	\N	reset-password	7aa9c96c-04c3-424e-8bf5-94873e7e3275	4ad402c9-e873-4196-a6bd-006ae9a99aac	0	30	f	\N	\N
c17f7273-8976-4e78-a813-0e3d2c70deda	\N	\N	7aa9c96c-04c3-424e-8bf5-94873e7e3275	4ad402c9-e873-4196-a6bd-006ae9a99aac	1	40	t	ccd3f020-24bd-4212-a0f8-e94a9ae75b89	\N
3209e7eb-fe8e-4661-a6f8-27afe393c351	\N	conditional-user-configured	7aa9c96c-04c3-424e-8bf5-94873e7e3275	ccd3f020-24bd-4212-a0f8-e94a9ae75b89	0	10	f	\N	\N
f9304fcf-a1c7-4caf-b81e-a21c500f8b0c	\N	reset-otp	7aa9c96c-04c3-424e-8bf5-94873e7e3275	ccd3f020-24bd-4212-a0f8-e94a9ae75b89	0	20	f	\N	\N
89e3e3bc-e4c4-40cc-a25d-1972544055ec	\N	client-secret	7aa9c96c-04c3-424e-8bf5-94873e7e3275	42718a46-01e8-4573-ad53-5155dc0f20df	2	10	f	\N	\N
5bccc379-caea-432e-a3bc-fdae4eaa98bc	\N	client-jwt	7aa9c96c-04c3-424e-8bf5-94873e7e3275	42718a46-01e8-4573-ad53-5155dc0f20df	2	20	f	\N	\N
1ef9d2de-1584-453d-b6dd-a56d36733fe4	\N	client-secret-jwt	7aa9c96c-04c3-424e-8bf5-94873e7e3275	42718a46-01e8-4573-ad53-5155dc0f20df	2	30	f	\N	\N
e0287bfe-f365-40e6-a246-5de53f0c2a3e	\N	client-x509	7aa9c96c-04c3-424e-8bf5-94873e7e3275	42718a46-01e8-4573-ad53-5155dc0f20df	2	40	f	\N	\N
f8135e90-7729-4d88-8828-2e3e4266f596	\N	idp-review-profile	7aa9c96c-04c3-424e-8bf5-94873e7e3275	cc8a27ae-105a-4bf3-8aa8-a029d2f9f5d5	0	10	f	\N	f2f61b0b-3d1d-464e-9ba2-13ecd5fb6510
7c687c2d-efce-4356-b69b-97e14f4f7cf3	\N	\N	7aa9c96c-04c3-424e-8bf5-94873e7e3275	cc8a27ae-105a-4bf3-8aa8-a029d2f9f5d5	0	20	t	a2bc54cc-15ef-482f-bff2-bc51d7e52b08	\N
6a15510b-1e0c-44e4-a08c-e3ac50854e42	\N	idp-create-user-if-unique	7aa9c96c-04c3-424e-8bf5-94873e7e3275	a2bc54cc-15ef-482f-bff2-bc51d7e52b08	2	10	f	\N	35b8f2e1-58e5-496f-88fb-48a97437c3ee
fed8854a-997a-42a4-8c46-c05398e5d5cc	\N	\N	7aa9c96c-04c3-424e-8bf5-94873e7e3275	a2bc54cc-15ef-482f-bff2-bc51d7e52b08	2	20	t	5fdf2abb-2c4b-4c38-8a7b-419a9102cffe	\N
a47f7077-1b90-4949-8963-e92fd687c85a	\N	idp-confirm-link	7aa9c96c-04c3-424e-8bf5-94873e7e3275	5fdf2abb-2c4b-4c38-8a7b-419a9102cffe	0	10	f	\N	\N
11d719d9-e2e9-4675-ac73-7a074a122421	\N	\N	7aa9c96c-04c3-424e-8bf5-94873e7e3275	5fdf2abb-2c4b-4c38-8a7b-419a9102cffe	0	20	t	bf6523f8-a308-402f-bf32-98a426f0dc33	\N
0993a19b-2a5a-4ad6-9a35-c364efcb9027	\N	idp-email-verification	7aa9c96c-04c3-424e-8bf5-94873e7e3275	bf6523f8-a308-402f-bf32-98a426f0dc33	2	10	f	\N	\N
5ff69f15-0cdd-45d4-b51e-733b0e489a8d	\N	\N	7aa9c96c-04c3-424e-8bf5-94873e7e3275	bf6523f8-a308-402f-bf32-98a426f0dc33	2	20	t	663bd6cf-01cc-4b2f-af6c-af9f06629302	\N
15db3f4c-d29f-4556-ba47-77a3ce017472	\N	idp-username-password-form	7aa9c96c-04c3-424e-8bf5-94873e7e3275	663bd6cf-01cc-4b2f-af6c-af9f06629302	0	10	f	\N	\N
92b5d660-1a9d-41f0-9af7-885c33b2d564	\N	\N	7aa9c96c-04c3-424e-8bf5-94873e7e3275	663bd6cf-01cc-4b2f-af6c-af9f06629302	1	20	t	1d9e0e00-7311-4e0d-8eab-f2f1c58cc0ee	\N
5e59954b-7b83-45ce-b829-3a706d6be231	\N	conditional-user-configured	7aa9c96c-04c3-424e-8bf5-94873e7e3275	1d9e0e00-7311-4e0d-8eab-f2f1c58cc0ee	0	10	f	\N	\N
f1242919-0e76-4d0c-b3b3-aa5a82c16fc8	\N	auth-otp-form	7aa9c96c-04c3-424e-8bf5-94873e7e3275	1d9e0e00-7311-4e0d-8eab-f2f1c58cc0ee	0	20	f	\N	\N
fcd947ae-d3d7-480a-be53-91a2927f9b58	\N	http-basic-authenticator	7aa9c96c-04c3-424e-8bf5-94873e7e3275	0e235008-a19d-47fa-acd8-7eefca5a5887	0	10	f	\N	\N
86edc539-6597-4a83-a7ac-93c2687eecd8	\N	docker-http-basic-authenticator	7aa9c96c-04c3-424e-8bf5-94873e7e3275	4a52b01d-7301-4418-891c-6b6490f6a65e	0	10	f	\N	\N
b6e8ce75-dcc9-437f-bba8-ee873d4349a8	\N	idp-email-verification	68507cda-c551-4ae5-8e9b-474fc4f60060	cea0999c-6509-46d6-a941-3bd678aa4445	2	10	f	\N	\N
76ea8564-cf81-49bc-802b-4bad32cc6222	\N	\N	68507cda-c551-4ae5-8e9b-474fc4f60060	cea0999c-6509-46d6-a941-3bd678aa4445	2	20	t	1e239992-046d-49a0-bdee-bc62512e56c3	\N
6f0a5903-f832-47f6-82a8-e04818f69552	\N	conditional-user-configured	68507cda-c551-4ae5-8e9b-474fc4f60060	ba217085-98f8-4fa9-90ac-560ca3a73da5	0	10	f	\N	\N
5f72e46d-6ba3-4298-975a-0a01f7b11305	\N	auth-otp-form	68507cda-c551-4ae5-8e9b-474fc4f60060	ba217085-98f8-4fa9-90ac-560ca3a73da5	0	20	f	\N	\N
8ab73229-a9a7-403c-a7b4-20ce308b8884	\N	conditional-user-configured	68507cda-c551-4ae5-8e9b-474fc4f60060	2f90e32b-1762-4663-977b-0e4659253172	0	10	f	\N	\N
84ff817c-412d-42a5-972d-9794cb411d92	\N	direct-grant-validate-otp	68507cda-c551-4ae5-8e9b-474fc4f60060	2f90e32b-1762-4663-977b-0e4659253172	0	20	f	\N	\N
e55140ec-142e-4b56-b30d-d2a646441deb	\N	conditional-user-configured	68507cda-c551-4ae5-8e9b-474fc4f60060	1c6244a3-97c5-4ddd-880e-f9e1836e965b	0	10	f	\N	\N
b974301c-2eab-4ab5-943b-8ea751c09236	\N	auth-otp-form	68507cda-c551-4ae5-8e9b-474fc4f60060	1c6244a3-97c5-4ddd-880e-f9e1836e965b	0	20	f	\N	\N
a53ae1d4-559f-4344-a95d-bb89d55c33e6	\N	idp-confirm-link	68507cda-c551-4ae5-8e9b-474fc4f60060	01822e53-967d-4a3e-ab67-65e448bb0203	0	10	f	\N	\N
19f91d62-5a59-40e3-b28e-798c158ca59e	\N	\N	68507cda-c551-4ae5-8e9b-474fc4f60060	01822e53-967d-4a3e-ab67-65e448bb0203	0	20	t	cea0999c-6509-46d6-a941-3bd678aa4445	\N
b2f6efdd-545a-4baf-bc8c-44f97371a8a7	\N	conditional-user-configured	68507cda-c551-4ae5-8e9b-474fc4f60060	9ab0625d-d051-4adf-a4bf-f45126c52498	0	10	f	\N	\N
61264a72-66a8-48e3-9b15-3df3aa2804bd	\N	reset-otp	68507cda-c551-4ae5-8e9b-474fc4f60060	9ab0625d-d051-4adf-a4bf-f45126c52498	0	20	f	\N	\N
d79a43cf-9726-4c7f-bb4a-66df82c92392	\N	idp-create-user-if-unique	68507cda-c551-4ae5-8e9b-474fc4f60060	018330f7-26eb-45ef-99f2-d4ae20dea186	2	10	f	\N	e851f2db-6b71-420f-848a-bc47e2b2c4ea
bdcf3fa6-d240-4dcb-888a-32f593037a9e	\N	\N	68507cda-c551-4ae5-8e9b-474fc4f60060	018330f7-26eb-45ef-99f2-d4ae20dea186	2	20	t	01822e53-967d-4a3e-ab67-65e448bb0203	\N
0060e2dd-6063-4d60-b812-69f9b731c8d4	\N	idp-username-password-form	68507cda-c551-4ae5-8e9b-474fc4f60060	1e239992-046d-49a0-bdee-bc62512e56c3	0	10	f	\N	\N
79b4554b-4256-454b-b8db-55a581542a6c	\N	\N	68507cda-c551-4ae5-8e9b-474fc4f60060	1e239992-046d-49a0-bdee-bc62512e56c3	1	20	t	1c6244a3-97c5-4ddd-880e-f9e1836e965b	\N
beec08f5-f012-46bd-9f47-d5d728d3ee3a	\N	auth-cookie	68507cda-c551-4ae5-8e9b-474fc4f60060	7e03d641-6c1a-46df-b0a1-6dc2094a9a0b	2	10	f	\N	\N
fef4b652-24b9-4fd1-a21d-7c7083f71281	\N	auth-spnego	68507cda-c551-4ae5-8e9b-474fc4f60060	7e03d641-6c1a-46df-b0a1-6dc2094a9a0b	3	20	f	\N	\N
0a6f9efb-18b8-4c99-9dba-a2c42a645194	\N	identity-provider-redirector	68507cda-c551-4ae5-8e9b-474fc4f60060	7e03d641-6c1a-46df-b0a1-6dc2094a9a0b	2	25	f	\N	\N
117598a2-82d5-4a63-9d94-8ac95c707f07	\N	\N	68507cda-c551-4ae5-8e9b-474fc4f60060	7e03d641-6c1a-46df-b0a1-6dc2094a9a0b	2	30	t	7a134bf4-825c-4552-a98c-e0ac17e06caf	\N
7857c77d-46f2-48a9-8fb7-66c080f6f4d1	\N	client-secret	68507cda-c551-4ae5-8e9b-474fc4f60060	146bdd15-653b-4851-89f1-40ce4060cff8	2	10	f	\N	\N
3fb86052-23c1-4694-8ec1-d26a15676f6b	\N	client-jwt	68507cda-c551-4ae5-8e9b-474fc4f60060	146bdd15-653b-4851-89f1-40ce4060cff8	2	20	f	\N	\N
a0cd78cb-aa6d-4e81-8e40-42e1ad923911	\N	client-secret-jwt	68507cda-c551-4ae5-8e9b-474fc4f60060	146bdd15-653b-4851-89f1-40ce4060cff8	2	30	f	\N	\N
dde4093d-9f5d-456c-9a5f-535b918a9540	\N	client-x509	68507cda-c551-4ae5-8e9b-474fc4f60060	146bdd15-653b-4851-89f1-40ce4060cff8	2	40	f	\N	\N
0c56f639-d5a3-44e3-be3a-a1ac84542947	\N	direct-grant-validate-username	68507cda-c551-4ae5-8e9b-474fc4f60060	8b8eb1ae-cbba-4f5f-b6ba-71cead5d9927	0	10	f	\N	\N
581a3903-81d1-4615-8979-9ab7aa673a27	\N	direct-grant-validate-password	68507cda-c551-4ae5-8e9b-474fc4f60060	8b8eb1ae-cbba-4f5f-b6ba-71cead5d9927	0	20	f	\N	\N
7b9e7793-90e8-4202-919d-43020e4ebed1	\N	\N	68507cda-c551-4ae5-8e9b-474fc4f60060	8b8eb1ae-cbba-4f5f-b6ba-71cead5d9927	1	30	t	2f90e32b-1762-4663-977b-0e4659253172	\N
10cb3a6c-102a-4a7b-89b5-7f8740bbc164	\N	docker-http-basic-authenticator	68507cda-c551-4ae5-8e9b-474fc4f60060	34c5e320-ea67-482f-adb2-ca8158065e8e	0	10	f	\N	\N
db07782c-7d9d-449b-81ec-d1cf61d0c423	\N	idp-review-profile	68507cda-c551-4ae5-8e9b-474fc4f60060	7c9b7abf-5e68-4be0-af9f-da80667d3407	0	10	f	\N	89132bb1-4443-4940-ac1b-e8278f54f7dc
7abe3d2b-12f3-403f-9bb2-f66b1d271a94	\N	\N	68507cda-c551-4ae5-8e9b-474fc4f60060	7c9b7abf-5e68-4be0-af9f-da80667d3407	0	20	t	018330f7-26eb-45ef-99f2-d4ae20dea186	\N
9cf3b122-c964-4e42-861b-d9364758c9f2	\N	auth-username-password-form	68507cda-c551-4ae5-8e9b-474fc4f60060	7a134bf4-825c-4552-a98c-e0ac17e06caf	0	10	f	\N	\N
6a753781-c29e-4652-844a-2333c999fc43	\N	\N	68507cda-c551-4ae5-8e9b-474fc4f60060	7a134bf4-825c-4552-a98c-e0ac17e06caf	1	20	t	ba217085-98f8-4fa9-90ac-560ca3a73da5	\N
455d7ed9-ee39-44f6-b55a-9a3f12757d12	\N	registration-page-form	68507cda-c551-4ae5-8e9b-474fc4f60060	1ccaa0d8-806c-4cc3-9b55-822508582c0f	0	10	t	bb37b743-c7d7-4d95-94b9-f90c24763d51	\N
b25af004-90be-4377-ba60-0b9e972224be	\N	registration-user-creation	68507cda-c551-4ae5-8e9b-474fc4f60060	bb37b743-c7d7-4d95-94b9-f90c24763d51	0	20	f	\N	\N
c8e37a0c-3e31-45a3-980a-db5ccdac74ea	\N	registration-password-action	68507cda-c551-4ae5-8e9b-474fc4f60060	bb37b743-c7d7-4d95-94b9-f90c24763d51	0	50	f	\N	\N
e94deb81-ce0b-42d1-b3a0-6b018478fa01	\N	registration-recaptcha-action	68507cda-c551-4ae5-8e9b-474fc4f60060	bb37b743-c7d7-4d95-94b9-f90c24763d51	3	60	f	\N	\N
4773e6f7-4b4e-45cf-9ac3-1be62c150597	\N	reset-credentials-choose-user	68507cda-c551-4ae5-8e9b-474fc4f60060	bc66bf72-231a-4a4a-a547-2e70e0527f1b	0	10	f	\N	\N
9cbd61e8-ea55-4141-b48b-e99edd8cd600	\N	reset-credential-email	68507cda-c551-4ae5-8e9b-474fc4f60060	bc66bf72-231a-4a4a-a547-2e70e0527f1b	0	20	f	\N	\N
97d4f2fe-5bc0-4a34-9f4d-495831ee00ee	\N	reset-password	68507cda-c551-4ae5-8e9b-474fc4f60060	bc66bf72-231a-4a4a-a547-2e70e0527f1b	0	30	f	\N	\N
bc2f0778-fe09-47aa-942f-2a1ea814f53d	\N	\N	68507cda-c551-4ae5-8e9b-474fc4f60060	bc66bf72-231a-4a4a-a547-2e70e0527f1b	1	40	t	9ab0625d-d051-4adf-a4bf-f45126c52498	\N
a280bb9d-0be7-4cf4-a31f-2df6928d1513	\N	http-basic-authenticator	68507cda-c551-4ae5-8e9b-474fc4f60060	9b9138b2-37dc-40b7-955c-b1b5e5dfa0ce	0	10	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
994f8ab2-6b42-49b5-9dba-378f346d9f25	browser	browser based authentication	7aa9c96c-04c3-424e-8bf5-94873e7e3275	basic-flow	t	t
23f49178-1d19-40f7-b5a6-eeeba49d008e	forms	Username, password, otp and other auth forms.	7aa9c96c-04c3-424e-8bf5-94873e7e3275	basic-flow	f	t
4e532fd4-4c93-45d5-ac36-dc8606378fed	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	7aa9c96c-04c3-424e-8bf5-94873e7e3275	basic-flow	f	t
a30e6232-d7bf-4925-8fa6-ded509a6b943	direct grant	OpenID Connect Resource Owner Grant	7aa9c96c-04c3-424e-8bf5-94873e7e3275	basic-flow	t	t
d25e1291-152f-4dfb-891c-ccdb39431ca3	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	7aa9c96c-04c3-424e-8bf5-94873e7e3275	basic-flow	f	t
bf29764d-ab50-49be-93e6-6da303c8c1a3	registration	registration flow	7aa9c96c-04c3-424e-8bf5-94873e7e3275	basic-flow	t	t
4b448feb-b074-4bfb-9f4b-df987bc0a817	registration form	registration form	7aa9c96c-04c3-424e-8bf5-94873e7e3275	form-flow	f	t
4ad402c9-e873-4196-a6bd-006ae9a99aac	reset credentials	Reset credentials for a user if they forgot their password or something	7aa9c96c-04c3-424e-8bf5-94873e7e3275	basic-flow	t	t
ccd3f020-24bd-4212-a0f8-e94a9ae75b89	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	7aa9c96c-04c3-424e-8bf5-94873e7e3275	basic-flow	f	t
42718a46-01e8-4573-ad53-5155dc0f20df	clients	Base authentication for clients	7aa9c96c-04c3-424e-8bf5-94873e7e3275	client-flow	t	t
cc8a27ae-105a-4bf3-8aa8-a029d2f9f5d5	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	7aa9c96c-04c3-424e-8bf5-94873e7e3275	basic-flow	t	t
a2bc54cc-15ef-482f-bff2-bc51d7e52b08	User creation or linking	Flow for the existing/non-existing user alternatives	7aa9c96c-04c3-424e-8bf5-94873e7e3275	basic-flow	f	t
5fdf2abb-2c4b-4c38-8a7b-419a9102cffe	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	7aa9c96c-04c3-424e-8bf5-94873e7e3275	basic-flow	f	t
bf6523f8-a308-402f-bf32-98a426f0dc33	Account verification options	Method with which to verity the existing account	7aa9c96c-04c3-424e-8bf5-94873e7e3275	basic-flow	f	t
663bd6cf-01cc-4b2f-af6c-af9f06629302	Verify Existing Account by Re-authentication	Reauthentication of existing account	7aa9c96c-04c3-424e-8bf5-94873e7e3275	basic-flow	f	t
1d9e0e00-7311-4e0d-8eab-f2f1c58cc0ee	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	7aa9c96c-04c3-424e-8bf5-94873e7e3275	basic-flow	f	t
0e235008-a19d-47fa-acd8-7eefca5a5887	saml ecp	SAML ECP Profile Authentication Flow	7aa9c96c-04c3-424e-8bf5-94873e7e3275	basic-flow	t	t
4a52b01d-7301-4418-891c-6b6490f6a65e	docker auth	Used by Docker clients to authenticate against the IDP	7aa9c96c-04c3-424e-8bf5-94873e7e3275	basic-flow	t	t
cea0999c-6509-46d6-a941-3bd678aa4445	Account verification options	Method with which to verity the existing account	68507cda-c551-4ae5-8e9b-474fc4f60060	basic-flow	f	t
ba217085-98f8-4fa9-90ac-560ca3a73da5	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	68507cda-c551-4ae5-8e9b-474fc4f60060	basic-flow	f	t
2f90e32b-1762-4663-977b-0e4659253172	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	68507cda-c551-4ae5-8e9b-474fc4f60060	basic-flow	f	t
1c6244a3-97c5-4ddd-880e-f9e1836e965b	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	68507cda-c551-4ae5-8e9b-474fc4f60060	basic-flow	f	t
01822e53-967d-4a3e-ab67-65e448bb0203	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	68507cda-c551-4ae5-8e9b-474fc4f60060	basic-flow	f	t
9ab0625d-d051-4adf-a4bf-f45126c52498	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	68507cda-c551-4ae5-8e9b-474fc4f60060	basic-flow	f	t
018330f7-26eb-45ef-99f2-d4ae20dea186	User creation or linking	Flow for the existing/non-existing user alternatives	68507cda-c551-4ae5-8e9b-474fc4f60060	basic-flow	f	t
1e239992-046d-49a0-bdee-bc62512e56c3	Verify Existing Account by Re-authentication	Reauthentication of existing account	68507cda-c551-4ae5-8e9b-474fc4f60060	basic-flow	f	t
7e03d641-6c1a-46df-b0a1-6dc2094a9a0b	browser	browser based authentication	68507cda-c551-4ae5-8e9b-474fc4f60060	basic-flow	t	t
146bdd15-653b-4851-89f1-40ce4060cff8	clients	Base authentication for clients	68507cda-c551-4ae5-8e9b-474fc4f60060	client-flow	t	t
8b8eb1ae-cbba-4f5f-b6ba-71cead5d9927	direct grant	OpenID Connect Resource Owner Grant	68507cda-c551-4ae5-8e9b-474fc4f60060	basic-flow	t	t
34c5e320-ea67-482f-adb2-ca8158065e8e	docker auth	Used by Docker clients to authenticate against the IDP	68507cda-c551-4ae5-8e9b-474fc4f60060	basic-flow	t	t
7c9b7abf-5e68-4be0-af9f-da80667d3407	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	68507cda-c551-4ae5-8e9b-474fc4f60060	basic-flow	t	t
7a134bf4-825c-4552-a98c-e0ac17e06caf	forms	Username, password, otp and other auth forms.	68507cda-c551-4ae5-8e9b-474fc4f60060	basic-flow	f	t
1ccaa0d8-806c-4cc3-9b55-822508582c0f	registration	registration flow	68507cda-c551-4ae5-8e9b-474fc4f60060	basic-flow	t	t
bb37b743-c7d7-4d95-94b9-f90c24763d51	registration form	registration form	68507cda-c551-4ae5-8e9b-474fc4f60060	form-flow	f	t
bc66bf72-231a-4a4a-a547-2e70e0527f1b	reset credentials	Reset credentials for a user if they forgot their password or something	68507cda-c551-4ae5-8e9b-474fc4f60060	basic-flow	t	t
9b9138b2-37dc-40b7-955c-b1b5e5dfa0ce	saml ecp	SAML ECP Profile Authentication Flow	68507cda-c551-4ae5-8e9b-474fc4f60060	basic-flow	t	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
f2f61b0b-3d1d-464e-9ba2-13ecd5fb6510	review profile config	7aa9c96c-04c3-424e-8bf5-94873e7e3275
35b8f2e1-58e5-496f-88fb-48a97437c3ee	create unique user config	7aa9c96c-04c3-424e-8bf5-94873e7e3275
e851f2db-6b71-420f-848a-bc47e2b2c4ea	create unique user config	68507cda-c551-4ae5-8e9b-474fc4f60060
89132bb1-4443-4940-ac1b-e8278f54f7dc	review profile config	68507cda-c551-4ae5-8e9b-474fc4f60060
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
35b8f2e1-58e5-496f-88fb-48a97437c3ee	false	require.password.update.after.registration
f2f61b0b-3d1d-464e-9ba2-13ecd5fb6510	missing	update.profile.on.first.login
89132bb1-4443-4940-ac1b-e8278f54f7dc	missing	update.profile.on.first.login
e851f2db-6b71-420f-848a-bc47e2b2c4ea	false	require.password.update.after.registration
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
75a512b0-fb5a-409d-aa9c-49ef04cdc299	t	f	master-realm	0	f	\N	\N	t	\N	f	7aa9c96c-04c3-424e-8bf5-94873e7e3275	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
aa841261-1c2f-4788-a9e7-74fac384acd8	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	7aa9c96c-04c3-424e-8bf5-94873e7e3275	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
72bc2e99-9371-4f71-a6ef-02d95ae5d000	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	7aa9c96c-04c3-424e-8bf5-94873e7e3275	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
349b16da-d67b-486b-9bac-1f891b9e4ec9	t	f	broker	0	f	\N	\N	t	\N	f	7aa9c96c-04c3-424e-8bf5-94873e7e3275	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
4ec0fb2f-b504-45f9-9329-cf0a9b44f3b7	t	f	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	7aa9c96c-04c3-424e-8bf5-94873e7e3275	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
a68d13b7-0a99-4323-ba9b-a556c5422a9d	t	f	admin-cli	0	t	\N	\N	f	\N	f	7aa9c96c-04c3-424e-8bf5-94873e7e3275	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
1499cf0a-a797-46f4-ae55-f7a762ee295a	t	f	example-realm	0	f	\N	\N	t	\N	f	7aa9c96c-04c3-424e-8bf5-94873e7e3275	\N	0	f	f	example Realm	f	client-secret	\N	\N	\N	t	f	f	f
2e36e0a5-741b-4d90-a187-79ff2d5262d0	t	f	account	0	t	\N	/realms/example/account/	f	\N	f	68507cda-c551-4ae5-8e9b-474fc4f60060	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
cec23f3d-0c0d-4446-b19d-777fa17d97c9	t	f	account-console	0	t	\N	/realms/example/account/	f	\N	f	68507cda-c551-4ae5-8e9b-474fc4f60060	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
4ae1de9a-6a6e-4d5d-a981-3930d1c014a1	t	f	admin-cli	0	t	\N	\N	f	\N	f	68507cda-c551-4ae5-8e9b-474fc4f60060	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
9d21a393-f724-4aad-adf5-a32b3e54cf06	t	f	broker	0	f	\N	\N	t	\N	f	68507cda-c551-4ae5-8e9b-474fc4f60060	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
7986828f-facd-4ed8-977d-70ead9b49ff0	t	t	spa-client	0	f	xyNcensqT1FG0Zs0CMQtC1dDW1Vw1Luz		f		f	68507cda-c551-4ae5-8e9b-474fc4f60060	openid-connect	-1	t	f		f	client-secret			\N	t	f	f	f
5461f065-8e95-4336-a83d-6c71669feb41	t	f	realm-management	0	f	\N	\N	t	\N	f	68507cda-c551-4ae5-8e9b-474fc4f60060	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
e450d026-67e5-4609-a564-0d272cbb7826	t	f	security-admin-console	0	t	\N	/admin/example/console/	f	\N	f	68507cda-c551-4ae5-8e9b-474fc4f60060	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_attributes (client_id, name, value) FROM stdin;
aa841261-1c2f-4788-a9e7-74fac384acd8	post.logout.redirect.uris	+
72bc2e99-9371-4f71-a6ef-02d95ae5d000	post.logout.redirect.uris	+
72bc2e99-9371-4f71-a6ef-02d95ae5d000	pkce.code.challenge.method	S256
4ec0fb2f-b504-45f9-9329-cf0a9b44f3b7	post.logout.redirect.uris	+
4ec0fb2f-b504-45f9-9329-cf0a9b44f3b7	pkce.code.challenge.method	S256
2e36e0a5-741b-4d90-a187-79ff2d5262d0	post.logout.redirect.uris	+
cec23f3d-0c0d-4446-b19d-777fa17d97c9	post.logout.redirect.uris	+
cec23f3d-0c0d-4446-b19d-777fa17d97c9	pkce.code.challenge.method	S256
4ae1de9a-6a6e-4d5d-a981-3930d1c014a1	post.logout.redirect.uris	+
9d21a393-f724-4aad-adf5-a32b3e54cf06	post.logout.redirect.uris	+
7986828f-facd-4ed8-977d-70ead9b49ff0	oidc.ciba.grant.enabled	false
7986828f-facd-4ed8-977d-70ead9b49ff0	client.secret.creation.time	1667490990
7986828f-facd-4ed8-977d-70ead9b49ff0	backchannel.logout.session.required	true
7986828f-facd-4ed8-977d-70ead9b49ff0	oauth2.device.authorization.grant.enabled	false
7986828f-facd-4ed8-977d-70ead9b49ff0	display.on.consent.screen	false
7986828f-facd-4ed8-977d-70ead9b49ff0	backchannel.logout.revoke.offline.tokens	false
5461f065-8e95-4336-a83d-6c71669feb41	post.logout.redirect.uris	+
e450d026-67e5-4609-a564-0d272cbb7826	post.logout.redirect.uris	+
e450d026-67e5-4609-a564-0d272cbb7826	pkce.code.challenge.method	S256
7986828f-facd-4ed8-977d-70ead9b49ff0	post.logout.redirect.uris	http://www.product.example/
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
23c348b7-7c78-4ded-8124-6c9e2a5d5d94	offline_access	7aa9c96c-04c3-424e-8bf5-94873e7e3275	OpenID Connect built-in scope: offline_access	openid-connect
604b586b-a4a0-4798-936d-acb761f39acf	role_list	7aa9c96c-04c3-424e-8bf5-94873e7e3275	SAML role list	saml
fd497d05-e3f5-4932-b76d-1c0a76c651f3	profile	7aa9c96c-04c3-424e-8bf5-94873e7e3275	OpenID Connect built-in scope: profile	openid-connect
3cc9757b-d962-4f88-9da1-d7f8274a4365	email	7aa9c96c-04c3-424e-8bf5-94873e7e3275	OpenID Connect built-in scope: email	openid-connect
1d720f36-9829-4030-aa69-aa06b2782285	address	7aa9c96c-04c3-424e-8bf5-94873e7e3275	OpenID Connect built-in scope: address	openid-connect
a3728da9-a45a-4937-9f81-dfac2a95f2bc	phone	7aa9c96c-04c3-424e-8bf5-94873e7e3275	OpenID Connect built-in scope: phone	openid-connect
943bc85e-622f-4d58-af01-f722a64a69a2	roles	7aa9c96c-04c3-424e-8bf5-94873e7e3275	OpenID Connect scope for add user roles to the access token	openid-connect
90e717d8-7122-49d8-8fdf-4cb9bbc54c0e	web-origins	7aa9c96c-04c3-424e-8bf5-94873e7e3275	OpenID Connect scope for add allowed web origins to the access token	openid-connect
58c8c8ff-d76a-43b2-bf22-352ca81e77b1	microprofile-jwt	7aa9c96c-04c3-424e-8bf5-94873e7e3275	Microprofile - JWT built-in scope	openid-connect
bcafe427-ccd8-4b4b-a6a1-3d26ce88bb77	acr	7aa9c96c-04c3-424e-8bf5-94873e7e3275	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
56f50926-caf1-438e-aa91-299a94aad2f6	profile	68507cda-c551-4ae5-8e9b-474fc4f60060	OpenID Connect built-in scope: profile	openid-connect
cf45d72f-4857-4106-953e-487ed89f4b65	role_list	68507cda-c551-4ae5-8e9b-474fc4f60060	SAML role list	saml
c5072f00-890e-41a3-8fec-3f2276ee765a	phone	68507cda-c551-4ae5-8e9b-474fc4f60060	OpenID Connect built-in scope: phone	openid-connect
c6b2bc7d-050e-423a-b6e1-d85206e66ab6	email	68507cda-c551-4ae5-8e9b-474fc4f60060	OpenID Connect built-in scope: email	openid-connect
b44476bf-b17b-4571-84d7-1cd18161766e	acr	68507cda-c551-4ae5-8e9b-474fc4f60060	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
789f9eaa-ba68-4f07-ae85-0e7d70235c9c	web-origins	68507cda-c551-4ae5-8e9b-474fc4f60060	OpenID Connect scope for add allowed web origins to the access token	openid-connect
1956f6f1-1bea-4afa-998b-ed36c4de5640	address	68507cda-c551-4ae5-8e9b-474fc4f60060	OpenID Connect built-in scope: address	openid-connect
15769899-23b3-47b4-b8d1-710c66d7acbe	offline_access	68507cda-c551-4ae5-8e9b-474fc4f60060	OpenID Connect built-in scope: offline_access	openid-connect
05aeab96-1872-4724-b68a-92ad0ed90189	roles	68507cda-c551-4ae5-8e9b-474fc4f60060	OpenID Connect scope for add user roles to the access token	openid-connect
395eea87-4dde-4f6c-9c61-9da6fb8a9f67	microprofile-jwt	68507cda-c551-4ae5-8e9b-474fc4f60060	Microprofile - JWT built-in scope	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
23c348b7-7c78-4ded-8124-6c9e2a5d5d94	true	display.on.consent.screen
23c348b7-7c78-4ded-8124-6c9e2a5d5d94	${offlineAccessScopeConsentText}	consent.screen.text
604b586b-a4a0-4798-936d-acb761f39acf	true	display.on.consent.screen
604b586b-a4a0-4798-936d-acb761f39acf	${samlRoleListScopeConsentText}	consent.screen.text
fd497d05-e3f5-4932-b76d-1c0a76c651f3	true	display.on.consent.screen
fd497d05-e3f5-4932-b76d-1c0a76c651f3	${profileScopeConsentText}	consent.screen.text
fd497d05-e3f5-4932-b76d-1c0a76c651f3	true	include.in.token.scope
3cc9757b-d962-4f88-9da1-d7f8274a4365	true	display.on.consent.screen
3cc9757b-d962-4f88-9da1-d7f8274a4365	${emailScopeConsentText}	consent.screen.text
3cc9757b-d962-4f88-9da1-d7f8274a4365	true	include.in.token.scope
1d720f36-9829-4030-aa69-aa06b2782285	true	display.on.consent.screen
1d720f36-9829-4030-aa69-aa06b2782285	${addressScopeConsentText}	consent.screen.text
1d720f36-9829-4030-aa69-aa06b2782285	true	include.in.token.scope
a3728da9-a45a-4937-9f81-dfac2a95f2bc	true	display.on.consent.screen
a3728da9-a45a-4937-9f81-dfac2a95f2bc	${phoneScopeConsentText}	consent.screen.text
a3728da9-a45a-4937-9f81-dfac2a95f2bc	true	include.in.token.scope
943bc85e-622f-4d58-af01-f722a64a69a2	true	display.on.consent.screen
943bc85e-622f-4d58-af01-f722a64a69a2	${rolesScopeConsentText}	consent.screen.text
943bc85e-622f-4d58-af01-f722a64a69a2	false	include.in.token.scope
90e717d8-7122-49d8-8fdf-4cb9bbc54c0e	false	display.on.consent.screen
90e717d8-7122-49d8-8fdf-4cb9bbc54c0e		consent.screen.text
90e717d8-7122-49d8-8fdf-4cb9bbc54c0e	false	include.in.token.scope
58c8c8ff-d76a-43b2-bf22-352ca81e77b1	false	display.on.consent.screen
58c8c8ff-d76a-43b2-bf22-352ca81e77b1	true	include.in.token.scope
bcafe427-ccd8-4b4b-a6a1-3d26ce88bb77	false	display.on.consent.screen
bcafe427-ccd8-4b4b-a6a1-3d26ce88bb77	false	include.in.token.scope
56f50926-caf1-438e-aa91-299a94aad2f6	true	include.in.token.scope
56f50926-caf1-438e-aa91-299a94aad2f6	true	display.on.consent.screen
56f50926-caf1-438e-aa91-299a94aad2f6	${profileScopeConsentText}	consent.screen.text
cf45d72f-4857-4106-953e-487ed89f4b65	${samlRoleListScopeConsentText}	consent.screen.text
cf45d72f-4857-4106-953e-487ed89f4b65	true	display.on.consent.screen
c5072f00-890e-41a3-8fec-3f2276ee765a	true	include.in.token.scope
c5072f00-890e-41a3-8fec-3f2276ee765a	true	display.on.consent.screen
c5072f00-890e-41a3-8fec-3f2276ee765a	${phoneScopeConsentText}	consent.screen.text
c6b2bc7d-050e-423a-b6e1-d85206e66ab6	true	include.in.token.scope
c6b2bc7d-050e-423a-b6e1-d85206e66ab6	true	display.on.consent.screen
c6b2bc7d-050e-423a-b6e1-d85206e66ab6	${emailScopeConsentText}	consent.screen.text
b44476bf-b17b-4571-84d7-1cd18161766e	false	include.in.token.scope
b44476bf-b17b-4571-84d7-1cd18161766e	false	display.on.consent.screen
789f9eaa-ba68-4f07-ae85-0e7d70235c9c	false	include.in.token.scope
789f9eaa-ba68-4f07-ae85-0e7d70235c9c	false	display.on.consent.screen
789f9eaa-ba68-4f07-ae85-0e7d70235c9c		consent.screen.text
1956f6f1-1bea-4afa-998b-ed36c4de5640	true	include.in.token.scope
1956f6f1-1bea-4afa-998b-ed36c4de5640	true	display.on.consent.screen
1956f6f1-1bea-4afa-998b-ed36c4de5640	${addressScopeConsentText}	consent.screen.text
15769899-23b3-47b4-b8d1-710c66d7acbe	${offlineAccessScopeConsentText}	consent.screen.text
15769899-23b3-47b4-b8d1-710c66d7acbe	true	display.on.consent.screen
05aeab96-1872-4724-b68a-92ad0ed90189	false	include.in.token.scope
05aeab96-1872-4724-b68a-92ad0ed90189	true	display.on.consent.screen
05aeab96-1872-4724-b68a-92ad0ed90189	${rolesScopeConsentText}	consent.screen.text
395eea87-4dde-4f6c-9c61-9da6fb8a9f67	true	include.in.token.scope
395eea87-4dde-4f6c-9c61-9da6fb8a9f67	false	display.on.consent.screen
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
aa841261-1c2f-4788-a9e7-74fac384acd8	bcafe427-ccd8-4b4b-a6a1-3d26ce88bb77	t
aa841261-1c2f-4788-a9e7-74fac384acd8	90e717d8-7122-49d8-8fdf-4cb9bbc54c0e	t
aa841261-1c2f-4788-a9e7-74fac384acd8	3cc9757b-d962-4f88-9da1-d7f8274a4365	t
aa841261-1c2f-4788-a9e7-74fac384acd8	943bc85e-622f-4d58-af01-f722a64a69a2	t
aa841261-1c2f-4788-a9e7-74fac384acd8	fd497d05-e3f5-4932-b76d-1c0a76c651f3	t
aa841261-1c2f-4788-a9e7-74fac384acd8	58c8c8ff-d76a-43b2-bf22-352ca81e77b1	f
aa841261-1c2f-4788-a9e7-74fac384acd8	1d720f36-9829-4030-aa69-aa06b2782285	f
aa841261-1c2f-4788-a9e7-74fac384acd8	23c348b7-7c78-4ded-8124-6c9e2a5d5d94	f
aa841261-1c2f-4788-a9e7-74fac384acd8	a3728da9-a45a-4937-9f81-dfac2a95f2bc	f
72bc2e99-9371-4f71-a6ef-02d95ae5d000	bcafe427-ccd8-4b4b-a6a1-3d26ce88bb77	t
72bc2e99-9371-4f71-a6ef-02d95ae5d000	90e717d8-7122-49d8-8fdf-4cb9bbc54c0e	t
72bc2e99-9371-4f71-a6ef-02d95ae5d000	3cc9757b-d962-4f88-9da1-d7f8274a4365	t
72bc2e99-9371-4f71-a6ef-02d95ae5d000	943bc85e-622f-4d58-af01-f722a64a69a2	t
72bc2e99-9371-4f71-a6ef-02d95ae5d000	fd497d05-e3f5-4932-b76d-1c0a76c651f3	t
72bc2e99-9371-4f71-a6ef-02d95ae5d000	58c8c8ff-d76a-43b2-bf22-352ca81e77b1	f
72bc2e99-9371-4f71-a6ef-02d95ae5d000	1d720f36-9829-4030-aa69-aa06b2782285	f
72bc2e99-9371-4f71-a6ef-02d95ae5d000	23c348b7-7c78-4ded-8124-6c9e2a5d5d94	f
72bc2e99-9371-4f71-a6ef-02d95ae5d000	a3728da9-a45a-4937-9f81-dfac2a95f2bc	f
a68d13b7-0a99-4323-ba9b-a556c5422a9d	bcafe427-ccd8-4b4b-a6a1-3d26ce88bb77	t
a68d13b7-0a99-4323-ba9b-a556c5422a9d	90e717d8-7122-49d8-8fdf-4cb9bbc54c0e	t
a68d13b7-0a99-4323-ba9b-a556c5422a9d	3cc9757b-d962-4f88-9da1-d7f8274a4365	t
a68d13b7-0a99-4323-ba9b-a556c5422a9d	943bc85e-622f-4d58-af01-f722a64a69a2	t
a68d13b7-0a99-4323-ba9b-a556c5422a9d	fd497d05-e3f5-4932-b76d-1c0a76c651f3	t
a68d13b7-0a99-4323-ba9b-a556c5422a9d	58c8c8ff-d76a-43b2-bf22-352ca81e77b1	f
a68d13b7-0a99-4323-ba9b-a556c5422a9d	1d720f36-9829-4030-aa69-aa06b2782285	f
a68d13b7-0a99-4323-ba9b-a556c5422a9d	23c348b7-7c78-4ded-8124-6c9e2a5d5d94	f
a68d13b7-0a99-4323-ba9b-a556c5422a9d	a3728da9-a45a-4937-9f81-dfac2a95f2bc	f
349b16da-d67b-486b-9bac-1f891b9e4ec9	bcafe427-ccd8-4b4b-a6a1-3d26ce88bb77	t
349b16da-d67b-486b-9bac-1f891b9e4ec9	90e717d8-7122-49d8-8fdf-4cb9bbc54c0e	t
349b16da-d67b-486b-9bac-1f891b9e4ec9	3cc9757b-d962-4f88-9da1-d7f8274a4365	t
349b16da-d67b-486b-9bac-1f891b9e4ec9	943bc85e-622f-4d58-af01-f722a64a69a2	t
349b16da-d67b-486b-9bac-1f891b9e4ec9	fd497d05-e3f5-4932-b76d-1c0a76c651f3	t
349b16da-d67b-486b-9bac-1f891b9e4ec9	58c8c8ff-d76a-43b2-bf22-352ca81e77b1	f
349b16da-d67b-486b-9bac-1f891b9e4ec9	1d720f36-9829-4030-aa69-aa06b2782285	f
349b16da-d67b-486b-9bac-1f891b9e4ec9	23c348b7-7c78-4ded-8124-6c9e2a5d5d94	f
349b16da-d67b-486b-9bac-1f891b9e4ec9	a3728da9-a45a-4937-9f81-dfac2a95f2bc	f
75a512b0-fb5a-409d-aa9c-49ef04cdc299	bcafe427-ccd8-4b4b-a6a1-3d26ce88bb77	t
75a512b0-fb5a-409d-aa9c-49ef04cdc299	90e717d8-7122-49d8-8fdf-4cb9bbc54c0e	t
75a512b0-fb5a-409d-aa9c-49ef04cdc299	3cc9757b-d962-4f88-9da1-d7f8274a4365	t
75a512b0-fb5a-409d-aa9c-49ef04cdc299	943bc85e-622f-4d58-af01-f722a64a69a2	t
75a512b0-fb5a-409d-aa9c-49ef04cdc299	fd497d05-e3f5-4932-b76d-1c0a76c651f3	t
75a512b0-fb5a-409d-aa9c-49ef04cdc299	58c8c8ff-d76a-43b2-bf22-352ca81e77b1	f
75a512b0-fb5a-409d-aa9c-49ef04cdc299	1d720f36-9829-4030-aa69-aa06b2782285	f
75a512b0-fb5a-409d-aa9c-49ef04cdc299	23c348b7-7c78-4ded-8124-6c9e2a5d5d94	f
75a512b0-fb5a-409d-aa9c-49ef04cdc299	a3728da9-a45a-4937-9f81-dfac2a95f2bc	f
4ec0fb2f-b504-45f9-9329-cf0a9b44f3b7	bcafe427-ccd8-4b4b-a6a1-3d26ce88bb77	t
4ec0fb2f-b504-45f9-9329-cf0a9b44f3b7	90e717d8-7122-49d8-8fdf-4cb9bbc54c0e	t
4ec0fb2f-b504-45f9-9329-cf0a9b44f3b7	3cc9757b-d962-4f88-9da1-d7f8274a4365	t
4ec0fb2f-b504-45f9-9329-cf0a9b44f3b7	943bc85e-622f-4d58-af01-f722a64a69a2	t
4ec0fb2f-b504-45f9-9329-cf0a9b44f3b7	fd497d05-e3f5-4932-b76d-1c0a76c651f3	t
4ec0fb2f-b504-45f9-9329-cf0a9b44f3b7	58c8c8ff-d76a-43b2-bf22-352ca81e77b1	f
4ec0fb2f-b504-45f9-9329-cf0a9b44f3b7	1d720f36-9829-4030-aa69-aa06b2782285	f
4ec0fb2f-b504-45f9-9329-cf0a9b44f3b7	23c348b7-7c78-4ded-8124-6c9e2a5d5d94	f
4ec0fb2f-b504-45f9-9329-cf0a9b44f3b7	a3728da9-a45a-4937-9f81-dfac2a95f2bc	f
2e36e0a5-741b-4d90-a187-79ff2d5262d0	789f9eaa-ba68-4f07-ae85-0e7d70235c9c	t
2e36e0a5-741b-4d90-a187-79ff2d5262d0	b44476bf-b17b-4571-84d7-1cd18161766e	t
2e36e0a5-741b-4d90-a187-79ff2d5262d0	56f50926-caf1-438e-aa91-299a94aad2f6	t
2e36e0a5-741b-4d90-a187-79ff2d5262d0	05aeab96-1872-4724-b68a-92ad0ed90189	t
2e36e0a5-741b-4d90-a187-79ff2d5262d0	c6b2bc7d-050e-423a-b6e1-d85206e66ab6	t
2e36e0a5-741b-4d90-a187-79ff2d5262d0	1956f6f1-1bea-4afa-998b-ed36c4de5640	f
2e36e0a5-741b-4d90-a187-79ff2d5262d0	c5072f00-890e-41a3-8fec-3f2276ee765a	f
2e36e0a5-741b-4d90-a187-79ff2d5262d0	15769899-23b3-47b4-b8d1-710c66d7acbe	f
2e36e0a5-741b-4d90-a187-79ff2d5262d0	395eea87-4dde-4f6c-9c61-9da6fb8a9f67	f
cec23f3d-0c0d-4446-b19d-777fa17d97c9	789f9eaa-ba68-4f07-ae85-0e7d70235c9c	t
cec23f3d-0c0d-4446-b19d-777fa17d97c9	b44476bf-b17b-4571-84d7-1cd18161766e	t
cec23f3d-0c0d-4446-b19d-777fa17d97c9	56f50926-caf1-438e-aa91-299a94aad2f6	t
cec23f3d-0c0d-4446-b19d-777fa17d97c9	05aeab96-1872-4724-b68a-92ad0ed90189	t
cec23f3d-0c0d-4446-b19d-777fa17d97c9	c6b2bc7d-050e-423a-b6e1-d85206e66ab6	t
cec23f3d-0c0d-4446-b19d-777fa17d97c9	1956f6f1-1bea-4afa-998b-ed36c4de5640	f
cec23f3d-0c0d-4446-b19d-777fa17d97c9	c5072f00-890e-41a3-8fec-3f2276ee765a	f
cec23f3d-0c0d-4446-b19d-777fa17d97c9	15769899-23b3-47b4-b8d1-710c66d7acbe	f
cec23f3d-0c0d-4446-b19d-777fa17d97c9	395eea87-4dde-4f6c-9c61-9da6fb8a9f67	f
4ae1de9a-6a6e-4d5d-a981-3930d1c014a1	789f9eaa-ba68-4f07-ae85-0e7d70235c9c	t
4ae1de9a-6a6e-4d5d-a981-3930d1c014a1	b44476bf-b17b-4571-84d7-1cd18161766e	t
4ae1de9a-6a6e-4d5d-a981-3930d1c014a1	56f50926-caf1-438e-aa91-299a94aad2f6	t
4ae1de9a-6a6e-4d5d-a981-3930d1c014a1	05aeab96-1872-4724-b68a-92ad0ed90189	t
4ae1de9a-6a6e-4d5d-a981-3930d1c014a1	c6b2bc7d-050e-423a-b6e1-d85206e66ab6	t
4ae1de9a-6a6e-4d5d-a981-3930d1c014a1	1956f6f1-1bea-4afa-998b-ed36c4de5640	f
4ae1de9a-6a6e-4d5d-a981-3930d1c014a1	c5072f00-890e-41a3-8fec-3f2276ee765a	f
4ae1de9a-6a6e-4d5d-a981-3930d1c014a1	15769899-23b3-47b4-b8d1-710c66d7acbe	f
4ae1de9a-6a6e-4d5d-a981-3930d1c014a1	395eea87-4dde-4f6c-9c61-9da6fb8a9f67	f
9d21a393-f724-4aad-adf5-a32b3e54cf06	789f9eaa-ba68-4f07-ae85-0e7d70235c9c	t
9d21a393-f724-4aad-adf5-a32b3e54cf06	b44476bf-b17b-4571-84d7-1cd18161766e	t
9d21a393-f724-4aad-adf5-a32b3e54cf06	56f50926-caf1-438e-aa91-299a94aad2f6	t
9d21a393-f724-4aad-adf5-a32b3e54cf06	05aeab96-1872-4724-b68a-92ad0ed90189	t
9d21a393-f724-4aad-adf5-a32b3e54cf06	c6b2bc7d-050e-423a-b6e1-d85206e66ab6	t
9d21a393-f724-4aad-adf5-a32b3e54cf06	1956f6f1-1bea-4afa-998b-ed36c4de5640	f
9d21a393-f724-4aad-adf5-a32b3e54cf06	c5072f00-890e-41a3-8fec-3f2276ee765a	f
9d21a393-f724-4aad-adf5-a32b3e54cf06	15769899-23b3-47b4-b8d1-710c66d7acbe	f
9d21a393-f724-4aad-adf5-a32b3e54cf06	395eea87-4dde-4f6c-9c61-9da6fb8a9f67	f
7986828f-facd-4ed8-977d-70ead9b49ff0	789f9eaa-ba68-4f07-ae85-0e7d70235c9c	t
7986828f-facd-4ed8-977d-70ead9b49ff0	b44476bf-b17b-4571-84d7-1cd18161766e	t
7986828f-facd-4ed8-977d-70ead9b49ff0	56f50926-caf1-438e-aa91-299a94aad2f6	t
7986828f-facd-4ed8-977d-70ead9b49ff0	05aeab96-1872-4724-b68a-92ad0ed90189	t
7986828f-facd-4ed8-977d-70ead9b49ff0	c6b2bc7d-050e-423a-b6e1-d85206e66ab6	t
7986828f-facd-4ed8-977d-70ead9b49ff0	1956f6f1-1bea-4afa-998b-ed36c4de5640	f
7986828f-facd-4ed8-977d-70ead9b49ff0	c5072f00-890e-41a3-8fec-3f2276ee765a	f
7986828f-facd-4ed8-977d-70ead9b49ff0	15769899-23b3-47b4-b8d1-710c66d7acbe	f
7986828f-facd-4ed8-977d-70ead9b49ff0	395eea87-4dde-4f6c-9c61-9da6fb8a9f67	f
5461f065-8e95-4336-a83d-6c71669feb41	789f9eaa-ba68-4f07-ae85-0e7d70235c9c	t
5461f065-8e95-4336-a83d-6c71669feb41	b44476bf-b17b-4571-84d7-1cd18161766e	t
5461f065-8e95-4336-a83d-6c71669feb41	56f50926-caf1-438e-aa91-299a94aad2f6	t
5461f065-8e95-4336-a83d-6c71669feb41	05aeab96-1872-4724-b68a-92ad0ed90189	t
5461f065-8e95-4336-a83d-6c71669feb41	c6b2bc7d-050e-423a-b6e1-d85206e66ab6	t
5461f065-8e95-4336-a83d-6c71669feb41	1956f6f1-1bea-4afa-998b-ed36c4de5640	f
5461f065-8e95-4336-a83d-6c71669feb41	c5072f00-890e-41a3-8fec-3f2276ee765a	f
5461f065-8e95-4336-a83d-6c71669feb41	15769899-23b3-47b4-b8d1-710c66d7acbe	f
5461f065-8e95-4336-a83d-6c71669feb41	395eea87-4dde-4f6c-9c61-9da6fb8a9f67	f
e450d026-67e5-4609-a564-0d272cbb7826	789f9eaa-ba68-4f07-ae85-0e7d70235c9c	t
e450d026-67e5-4609-a564-0d272cbb7826	b44476bf-b17b-4571-84d7-1cd18161766e	t
e450d026-67e5-4609-a564-0d272cbb7826	56f50926-caf1-438e-aa91-299a94aad2f6	t
e450d026-67e5-4609-a564-0d272cbb7826	05aeab96-1872-4724-b68a-92ad0ed90189	t
e450d026-67e5-4609-a564-0d272cbb7826	c6b2bc7d-050e-423a-b6e1-d85206e66ab6	t
e450d026-67e5-4609-a564-0d272cbb7826	1956f6f1-1bea-4afa-998b-ed36c4de5640	f
e450d026-67e5-4609-a564-0d272cbb7826	c5072f00-890e-41a3-8fec-3f2276ee765a	f
e450d026-67e5-4609-a564-0d272cbb7826	15769899-23b3-47b4-b8d1-710c66d7acbe	f
e450d026-67e5-4609-a564-0d272cbb7826	395eea87-4dde-4f6c-9c61-9da6fb8a9f67	f
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
23c348b7-7c78-4ded-8124-6c9e2a5d5d94	839a4ab2-997d-42e3-8a08-9a06a8a393e4
15769899-23b3-47b4-b8d1-710c66d7acbe	ed2d2483-278c-48da-84d1-636df5351394
\.


--
-- Data for Name: client_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session (id, client_id, redirect_uri, state, "timestamp", session_id, auth_method, realm_id, auth_user_id, current_action) FROM stdin;
\.


--
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session_auth_status (authenticator, status, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session_prot_mapper (protocol_mapper_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session_role (role_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_user_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
91dad17f-0056-49a5-8c87-b5bd67847f03	Trusted Hosts	7aa9c96c-04c3-424e-8bf5-94873e7e3275	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	7aa9c96c-04c3-424e-8bf5-94873e7e3275	anonymous
d6ba2f13-c915-47d1-a820-83de5b432899	Consent Required	7aa9c96c-04c3-424e-8bf5-94873e7e3275	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	7aa9c96c-04c3-424e-8bf5-94873e7e3275	anonymous
e71345a0-bb95-4000-83bb-da018afb9285	Full Scope Disabled	7aa9c96c-04c3-424e-8bf5-94873e7e3275	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	7aa9c96c-04c3-424e-8bf5-94873e7e3275	anonymous
5384bb06-0f0d-46d0-9b12-e7fa89a88109	Max Clients Limit	7aa9c96c-04c3-424e-8bf5-94873e7e3275	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	7aa9c96c-04c3-424e-8bf5-94873e7e3275	anonymous
388244ed-15aa-4421-9815-0639f17afe1a	Allowed Protocol Mapper Types	7aa9c96c-04c3-424e-8bf5-94873e7e3275	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	7aa9c96c-04c3-424e-8bf5-94873e7e3275	anonymous
267488b6-ad4c-4516-b6ed-1b8124a88c30	Allowed Client Scopes	7aa9c96c-04c3-424e-8bf5-94873e7e3275	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	7aa9c96c-04c3-424e-8bf5-94873e7e3275	anonymous
dc0542a8-68de-4952-b819-04c2cdd94b41	Allowed Protocol Mapper Types	7aa9c96c-04c3-424e-8bf5-94873e7e3275	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	7aa9c96c-04c3-424e-8bf5-94873e7e3275	authenticated
512987c5-c433-41b3-9149-9af554322d24	Allowed Client Scopes	7aa9c96c-04c3-424e-8bf5-94873e7e3275	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	7aa9c96c-04c3-424e-8bf5-94873e7e3275	authenticated
6bcaea38-c2f4-494a-b0dd-819582eda26c	rsa-generated	7aa9c96c-04c3-424e-8bf5-94873e7e3275	rsa-generated	org.keycloak.keys.KeyProvider	7aa9c96c-04c3-424e-8bf5-94873e7e3275	\N
d43afdc3-b138-43b6-861c-45ec6f454fbb	rsa-enc-generated	7aa9c96c-04c3-424e-8bf5-94873e7e3275	rsa-enc-generated	org.keycloak.keys.KeyProvider	7aa9c96c-04c3-424e-8bf5-94873e7e3275	\N
fb8cc4ab-8523-4715-b9fd-1028fbebcfe3	hmac-generated	7aa9c96c-04c3-424e-8bf5-94873e7e3275	hmac-generated	org.keycloak.keys.KeyProvider	7aa9c96c-04c3-424e-8bf5-94873e7e3275	\N
a1152e24-d04b-4b7a-96f9-9ce84e11dff5	aes-generated	7aa9c96c-04c3-424e-8bf5-94873e7e3275	aes-generated	org.keycloak.keys.KeyProvider	7aa9c96c-04c3-424e-8bf5-94873e7e3275	\N
d1484629-ec94-4046-8b44-a1a2e9a77ae4	Allowed Protocol Mapper Types	68507cda-c551-4ae5-8e9b-474fc4f60060	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	68507cda-c551-4ae5-8e9b-474fc4f60060	anonymous
e8d38bae-a0aa-4cc5-8502-e0ebc0ae7fdd	Trusted Hosts	68507cda-c551-4ae5-8e9b-474fc4f60060	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	68507cda-c551-4ae5-8e9b-474fc4f60060	anonymous
d04d4205-3801-4609-b39b-a71b870ab65c	Max Clients Limit	68507cda-c551-4ae5-8e9b-474fc4f60060	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	68507cda-c551-4ae5-8e9b-474fc4f60060	anonymous
080cea4f-3e51-475c-b159-d3626379c0ac	Allowed Client Scopes	68507cda-c551-4ae5-8e9b-474fc4f60060	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	68507cda-c551-4ae5-8e9b-474fc4f60060	anonymous
882c9f59-d116-455f-8aa0-530b25df03bd	Full Scope Disabled	68507cda-c551-4ae5-8e9b-474fc4f60060	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	68507cda-c551-4ae5-8e9b-474fc4f60060	anonymous
34d468f5-42f5-40c4-89b4-492e9dde841b	Allowed Protocol Mapper Types	68507cda-c551-4ae5-8e9b-474fc4f60060	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	68507cda-c551-4ae5-8e9b-474fc4f60060	authenticated
8c88c66a-57e3-483f-acc5-f32e558a0f19	Allowed Client Scopes	68507cda-c551-4ae5-8e9b-474fc4f60060	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	68507cda-c551-4ae5-8e9b-474fc4f60060	authenticated
09b61d06-bd85-482d-ad1d-531a53835c38	Consent Required	68507cda-c551-4ae5-8e9b-474fc4f60060	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	68507cda-c551-4ae5-8e9b-474fc4f60060	anonymous
06b7ac66-cff3-4f32-9d05-6191c295d747	rsa-generated	68507cda-c551-4ae5-8e9b-474fc4f60060	rsa-generated	org.keycloak.keys.KeyProvider	68507cda-c551-4ae5-8e9b-474fc4f60060	\N
43b06b3a-da47-4411-ace1-9e2f5d3a8aa3	rsa-enc-generated	68507cda-c551-4ae5-8e9b-474fc4f60060	rsa-enc-generated	org.keycloak.keys.KeyProvider	68507cda-c551-4ae5-8e9b-474fc4f60060	\N
70eb8616-ff4c-4c5b-b3b7-9dd78795b626	aes-generated	68507cda-c551-4ae5-8e9b-474fc4f60060	aes-generated	org.keycloak.keys.KeyProvider	68507cda-c551-4ae5-8e9b-474fc4f60060	\N
417d29a2-dfe3-479b-ae51-25454014cb58	hmac-generated	68507cda-c551-4ae5-8e9b-474fc4f60060	hmac-generated	org.keycloak.keys.KeyProvider	68507cda-c551-4ae5-8e9b-474fc4f60060	\N
cca146f3-c7a6-4ea6-9c4f-5aea87d9e68b	\N	7aa9c96c-04c3-424e-8bf5-94873e7e3275	declarative-user-profile	org.keycloak.userprofile.UserProfileProvider	7aa9c96c-04c3-424e-8bf5-94873e7e3275	\N
08e57fa6-b1ce-4d7d-b19c-033c04c19a14	hmac-generated-hs512	7aa9c96c-04c3-424e-8bf5-94873e7e3275	hmac-generated	org.keycloak.keys.KeyProvider	7aa9c96c-04c3-424e-8bf5-94873e7e3275	\N
37099f6d-8da7-4eda-9070-fd1dacbc3202	\N	68507cda-c551-4ae5-8e9b-474fc4f60060	declarative-user-profile	org.keycloak.userprofile.UserProfileProvider	68507cda-c551-4ae5-8e9b-474fc4f60060	\N
bfbb1e13-7894-4c15-b817-4e8ca7d0241e	hmac-generated-hs512	68507cda-c551-4ae5-8e9b-474fc4f60060	hmac-generated	org.keycloak.keys.KeyProvider	68507cda-c551-4ae5-8e9b-474fc4f60060	\N
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
4c0d3c6d-c2b4-49ce-808c-eb4f2a942d67	dc0542a8-68de-4952-b819-04c2cdd94b41	allowed-protocol-mapper-types	oidc-full-name-mapper
89ff9da9-d615-4b69-a4e0-59b57e183401	dc0542a8-68de-4952-b819-04c2cdd94b41	allowed-protocol-mapper-types	saml-user-property-mapper
daf1c1d3-4694-4ad4-bfa2-05ea6f96151a	dc0542a8-68de-4952-b819-04c2cdd94b41	allowed-protocol-mapper-types	saml-user-attribute-mapper
41aef47b-66f3-44cb-afc8-444d1f92ed48	dc0542a8-68de-4952-b819-04c2cdd94b41	allowed-protocol-mapper-types	saml-role-list-mapper
9d5ed059-6ab4-4a71-a3f3-70fb5febfd6c	dc0542a8-68de-4952-b819-04c2cdd94b41	allowed-protocol-mapper-types	oidc-address-mapper
1fbaa5fd-b62d-4097-a9ce-985d76ef69e4	dc0542a8-68de-4952-b819-04c2cdd94b41	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
2dcba2ad-2dcc-43c2-b0c3-7dac132e2bea	dc0542a8-68de-4952-b819-04c2cdd94b41	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
51c52b3a-b510-4627-9228-a82ca6b41efe	dc0542a8-68de-4952-b819-04c2cdd94b41	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
60383f52-d4d5-40cf-b2fc-eff1d80f8f6d	5384bb06-0f0d-46d0-9b12-e7fa89a88109	max-clients	200
a629387f-5664-4bc9-9fc6-e6a95cb55c51	267488b6-ad4c-4516-b6ed-1b8124a88c30	allow-default-scopes	true
e5310f4b-ae92-4067-a740-d2d0f7eda41b	91dad17f-0056-49a5-8c87-b5bd67847f03	client-uris-must-match	true
1a79b90c-a1e3-4369-8d49-cf8036007854	91dad17f-0056-49a5-8c87-b5bd67847f03	host-sending-registration-request-must-match	true
f434b2be-2055-40cc-a793-6e06714d3eb5	388244ed-15aa-4421-9815-0639f17afe1a	allowed-protocol-mapper-types	saml-user-attribute-mapper
b4ac91ad-89ee-437d-a622-8a9bf9a5da43	388244ed-15aa-4421-9815-0639f17afe1a	allowed-protocol-mapper-types	oidc-full-name-mapper
93f3f973-8dd2-46f4-8eda-253a80b59e08	388244ed-15aa-4421-9815-0639f17afe1a	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
48b4c649-0392-4995-bfd5-da7d3cf07782	388244ed-15aa-4421-9815-0639f17afe1a	allowed-protocol-mapper-types	saml-user-property-mapper
aa64402b-cfac-4dbb-a2c2-48902acf1517	388244ed-15aa-4421-9815-0639f17afe1a	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
cd27ba52-441f-43b6-9ea3-9f2fecdd5f29	388244ed-15aa-4421-9815-0639f17afe1a	allowed-protocol-mapper-types	oidc-address-mapper
f6540968-fb3c-47e0-aafc-12bb4f1280fd	388244ed-15aa-4421-9815-0639f17afe1a	allowed-protocol-mapper-types	saml-role-list-mapper
2b370e21-52b6-426d-ab21-5f2db6b9239a	388244ed-15aa-4421-9815-0639f17afe1a	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
810e47b8-628b-4e29-aeaf-6722a30c720a	512987c5-c433-41b3-9149-9af554322d24	allow-default-scopes	true
b6a353a0-08f3-4307-a2d0-f479eda1cc09	6bcaea38-c2f4-494a-b0dd-819582eda26c	priority	100
69328b09-2c40-42a5-9ae3-72031999be25	6bcaea38-c2f4-494a-b0dd-819582eda26c	keyUse	SIG
caa97c08-7fb0-4bb8-8d95-6a0b41a16fe0	6bcaea38-c2f4-494a-b0dd-819582eda26c	privateKey	MIIEowIBAAKCAQEA+yfUjtxmf9GeBumtfd/aVjpmwpb0+gd9Ey0h04YrHc1NwOaA+PhY5wC9ljwhYy8AB5CK62OUTWpjFOCIFLd7GkPkIWT6wvCUumZjOe39L/QcB4DWZAz5JXyHU6ZgCKQVLW8y3kffn3eeJ86+qiUUS4yuTNaJRR+6eSAr+Tc9rPTGjaeVzFQgoKaWDnqCoIFvg7ofSoWPpkGoMKvOLcNUUgupg8ZWMSrkqGqdIwhQ9dsgWah+tJXEhgpvrs9L6R6FWr43Zxqq2CiuFT+3uVjzqUSfy2XC9EqM5uLWYw0Pn7T+A/MLZ+WFEgvsoUeiO0XbHU8AvkitijeMhRYNZb00XQIDAQABAoIBABEepa1IRj9bt0Ei4BXWsrASgosslY3OgV7Tgn0D5f/9zNlDjRKLgSnb4dByEFeNrluVpXaGnucJA7B6XqRE3oILkysYkkRD+GtdS9G40HuakOeNB3Ah90CwJJxV2LF2F9B1RjsjHJHm6jOt8s6vwNqmgAISVKCO2VvkzsKJ2q0ljqp9I8VyLv00Lb7O3EYv6BADgXVjRt8yAcSinzJR1t4YmqfwF9ji93eEX2iUrstb/LvfmcNMBZNoWY1gK/volU34gD2cpSx6vgnDutP/tBRqZ6gvq1wU3fBOXDRSD3TgwgTKaY4Gm5Yhb6g0RFqrNERSAuO+QYlLUwOUc/OfoekCgYEA/zmZtrdDpB0U/RNHj9yAG38RrFHYGkaJmSvk2Gi04pk/TkrmtDSQelqNgEJE4u3r/QpH1CGsppnwFNgFbbK1lb86DgE9wx/LuwsvjXG1DCw+xWhcYwPCvu51pphk7Uw/rg0C3fNZdu5BQW6fjPEbH+y/C4+5XUV3N15nyPe0bmkCgYEA++sRBc1G5vACuPHEINKURmX1p/ifAKSt5z1829eXxGdak0PVWCYwdwbp8HRHK0Rj3WP1vWtIFIOJxjP/h1xbXvMpmy/NITDeM7HA7zLZyBtGLMJJ/7kLm2qpwitYa4JdfksukF5ul/Jr2pifXotzCmnsiaz36Ne/wZgBUO61v9UCgYAQuu3glFLSxzVBAaqHO6UKKGI4MYVA867BY6c0qGhzEiicMTy+Q1PVMWplJfLuDTqS88GRnkN7CEw8kYyJjFVq44YitOIfkE4CjNEpLHL5wUy8FAM6WlzBt0/vA75Z782c0y2E7xbGPQf6Cg5bZtKoXRSI5Xr5KjyOXJnhCpvBQQKBgQDKYMBvIcco9X2qaAdAuwsFNxnPlCrgUGuojjwFPMCets0L632z8BIVPQeo9TDLcIitrYUYY9wnJrkC8nkAnFCHCd/N3Ov1ExYe/1jYkMhmOor4oCjkeBr8AwdXhozk6XkEYY+JyWMdTFIa7Wtyf6KupgOxYrRSaSiSdPPxuaNm9QKBgFck29Lc6VVFQSb/7CuJ4muFJfhpvuZ/01ty0s/+IFTATkJy43HQ7ftDVV0WTBf/rtJ3kyMbhpOvL4sW6Fl6bLygColxHM7ltvXxTEA/Y6EXBC1d4uT7quJYxCMAl/4EJgPAEhC8PmDWaLUOhUFLAFShyzzJeoQY66wOomznci82
0fbdafc7-3b1f-428e-ab0d-539f2059ba18	6bcaea38-c2f4-494a-b0dd-819582eda26c	certificate	MIICmzCCAYMCBgGEdeMv2zANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjIxMTE0MTEyMzU0WhcNMzIxMTE0MTEyNTM0WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQD7J9SO3GZ/0Z4G6a1939pWOmbClvT6B30TLSHThisdzU3A5oD4+FjnAL2WPCFjLwAHkIrrY5RNamMU4IgUt3saQ+QhZPrC8JS6ZmM57f0v9BwHgNZkDPklfIdTpmAIpBUtbzLeR9+fd54nzr6qJRRLjK5M1olFH7p5ICv5Nz2s9MaNp5XMVCCgppYOeoKggW+Duh9KhY+mQagwq84tw1RSC6mDxlYxKuSoap0jCFD12yBZqH60lcSGCm+uz0vpHoVavjdnGqrYKK4VP7e5WPOpRJ/LZcL0Sozm4tZjDQ+ftP4D8wtn5YUSC+yhR6I7RdsdTwC+SK2KN4yFFg1lvTRdAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAGL3jIOu/AAEDRjqAh4JIu3lDqkmm2fZc7sO/aYfkopdEznGFEtwKtxpp09g7oBntPRbLCZN/JEOBkA1Asm3bqcEha172wtip3nG48YyDIMnFNRoG+TLXrVRH+l+YXu5UC+WhWqhuJL4Qbkq+l0JQ75uZm9ckia0Dh8CIe1XlwvFvb7/qVFgC5VqlKNoboyb6jLPNTK+j3xEhPGaIyFAow4At6KzMzmfyvvLx068zuSmbmyRshqlR5NhiULXLSyKCI9F8yaJeY6HdylxtecV6aKBeC0X0TB5dUuOZ9MkdeJJXK+r5WK43g8eYBE+zYOFC12uP1rMx7FipM/V/g/r/Tw=
59bfc241-99c2-4b96-b20b-38d85b0ffa19	a1152e24-d04b-4b7a-96f9-9ce84e11dff5	priority	100
7ea1cd6c-1512-4960-9969-fdbd769fc93e	a1152e24-d04b-4b7a-96f9-9ce84e11dff5	kid	dfedda1a-8a54-4352-a446-d9d2db532eb8
34bb14bb-7af3-4ca7-b9cb-c8e4c4374ab9	a1152e24-d04b-4b7a-96f9-9ce84e11dff5	secret	3UOSq2XWdz6PjzJCT_y0tA
08d9d2b3-8419-48d8-8977-5f67dc04a51a	fb8cc4ab-8523-4715-b9fd-1028fbebcfe3	secret	FgfygKBfDvDIfUuA1FsYPhFAP_PvJaaKxm3iDBKDq9dPLytZM-nkBYsD6-SgP6afFtw3CU3i2DlRHIqTBXhGIQ
addfa1a7-46f4-4bf9-9a48-4cef6c208dad	fb8cc4ab-8523-4715-b9fd-1028fbebcfe3	kid	eacdaef8-c663-4aa4-8d92-b12a5b5e4905
4377f0b4-a4d5-4094-b3e5-f471ecde5092	fb8cc4ab-8523-4715-b9fd-1028fbebcfe3	priority	100
1ec32f4f-1290-4a63-8cb2-3ec8bd8d35ee	fb8cc4ab-8523-4715-b9fd-1028fbebcfe3	algorithm	HS256
f4415db8-ea36-4b8a-81a0-ef90360f8aac	d43afdc3-b138-43b6-861c-45ec6f454fbb	algorithm	RSA-OAEP
c7e81974-c9b2-445e-bd99-b29c8e6b3379	d43afdc3-b138-43b6-861c-45ec6f454fbb	keyUse	ENC
91e97fa1-df50-43d8-a566-491807b456bf	34d468f5-42f5-40c4-89b4-492e9dde841b	allowed-protocol-mapper-types	saml-role-list-mapper
6e973c97-0a3a-4e00-bf0e-561981f60b89	34d468f5-42f5-40c4-89b4-492e9dde841b	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
9891d117-f310-4ff6-bebc-ad544818e683	34d468f5-42f5-40c4-89b4-492e9dde841b	allowed-protocol-mapper-types	oidc-full-name-mapper
f48c61c2-8d98-4df3-b868-2af2a0755b1e	34d468f5-42f5-40c4-89b4-492e9dde841b	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
ab5e4017-768c-4ecb-9de2-f3f5a1670b56	d43afdc3-b138-43b6-861c-45ec6f454fbb	privateKey	MIIEowIBAAKCAQEAxaxo5FJQCfYzJHOJ5bLvwsz2jPSNHpHyLTI1KSN6dbZFidBHHkA3xt/Id70bltw2pHb3OjDvrmZVX0fJ9/dg32fYOgXahTjDtTxAO2i0t6htJDIkfxDz7JE840RkPuVXmF/kIOcnz6I0GLnIQRxBxB/WNgFGlM5CclGIpvWRsmmYDBghS6nU/SLX7AC+1vityYJ+T99CQlqTnM/MdhguCQXnkDaNAEBMSFETzrXv0A6dPupKQXX9o5a+VsVTkdmV6SMpocqE8fLZtixFBzvJl3es8uEmmRAxapxrawpYV+dXclPApCNMvfoFP2gVTC2t+m5ehoCqNkLPaPFA52BeWQIDAQABAoIBABKTMNCauQV0nonrdv7wDXZsUPM+JDgmDgAn/oWY/UAMMpTgjtxFe9BK9VEmIq5uj05tVO5BjLZCTL2tNun/k5lurkuGgwofg0l3qdADVu8Gq0naUeJkVw2I+NQg2DwuTCjIAv2CBzRMSVG0/H+8zmPF+5i7zjR7vNP1/C23N/uQJQ2vQq9a4gWIrxKxM4lInew1I+rq4KrDAMeJOGma7WJ8MKIat+8c3X2U1PdDw/6nxyYKr7jJbQWN+iWGgu0+CKwKPPa23hA6oE6s9/gIumLJM9daS+qUyx09jo6+JyYNV2AZ9a3znRHsSOLyOTa571o+wVWKYScR7TXx3maaiFECgYEA6uj9B8WvJSz8SRMpMS6LoDIVn3nm1cZWBT1faCk7srG5gS9VrFFouDKuGr8KAiZebi3HKdamDBt7KdCz2Kuwro1Y9Jd5IsC8rw+dfpsCWuQyjno+VdA0tKbilgpCk/igDlsvX43UPlrUH73zgvdU5zLITb28yyOKcDSFt9eI3bECgYEA12uZqcZYviB27ZFuERHgQmMCQrA2jl48lGDCRSQNTOAQWmo82oRV2K/Iig52LxYDD4SftvuU/Y0d7PkQQCVPf9JZfIQDoHg28yCYEfrwhI9cWd3OFVUalOOU7aMN05FSwFRVfK1lb2tOjy6yTPxAQUsDkUSnY2f/HdZHEza47SkCgYBf9D+3Nwat9swuxUbkMhESpKK0e8TQua1VgpZAI+egvHv7yuwB8VcHNpxrjHF4I1gbRVO/QVCeTXNnxzpPXQJUqqQVdPIkQfpQv94jYwn5OpF0JXbk8qE00Z5oj1RWwQ4QDyswquxxdASF2r9nVcQ2lEXBi6lciO35m1qrl7zuYQKBgFi6tzZYvmDBmnrL9hwN0uNFSL8TOcV2R1mOaTZ1XQ0XFWVIcPxImduAvAcxYbiPRn9zzx1djsbJA1SCWhExzQcHK1jAP4YvPeLyv/BX/g17xzw0whfDUAmXm9Yt3RoRt5YEppmOCkPUXS1YvJQ9KnI6ZaPGNXQad9hgVDIzzgPRAoGBALZ0FAPKUMy66cy4NY6nJvoBVffZ+DmT1KDZZ2mtgWLbS8rn/4Iw29Aoskzl6ad2fES7Cnxz3QiBKADrJD66ErFN8iq4/J2DEFqz8xa9NdKWf17Y6Vr1TF+WIRiQskqYi5y7pJ7G1F9b4Y27fYzYjH822YBwe7EX8U7Q0MEztPYq
84c8019f-c234-41fd-9cab-558704736e8c	34d468f5-42f5-40c4-89b4-492e9dde841b	allowed-protocol-mapper-types	oidc-address-mapper
e026d541-135e-415c-8dc7-45033b7348e3	34d468f5-42f5-40c4-89b4-492e9dde841b	allowed-protocol-mapper-types	saml-user-attribute-mapper
ca78a11b-348c-46d2-bed2-ce08d199b24f	d43afdc3-b138-43b6-861c-45ec6f454fbb	certificate	MIICmzCCAYMCBgGEdeMxpzANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjIxMTE0MTEyMzU0WhcNMzIxMTE0MTEyNTM0WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDFrGjkUlAJ9jMkc4nlsu/CzPaM9I0ekfItMjUpI3p1tkWJ0EceQDfG38h3vRuW3Dakdvc6MO+uZlVfR8n392DfZ9g6BdqFOMO1PEA7aLS3qG0kMiR/EPPskTzjRGQ+5VeYX+Qg5yfPojQYuchBHEHEH9Y2AUaUzkJyUYim9ZGyaZgMGCFLqdT9ItfsAL7W+K3Jgn5P30JCWpOcz8x2GC4JBeeQNo0AQExIURPOte/QDp0+6kpBdf2jlr5WxVOR2ZXpIymhyoTx8tm2LEUHO8mXd6zy4SaZEDFqnGtrClhX51dyU8CkI0y9+gU/aBVMLa36bl6GgKo2Qs9o8UDnYF5ZAgMBAAEwDQYJKoZIhvcNAQELBQADggEBADwCZwOUvyTQNh+afM+1tlJKq80uyyeKmo3NxPiiHieFJf2jG59dKLnxui7TA2s8i04P+plXorSGHs8QdpIYsRYqcU1soAewbeT1rr6LbGII4zEz5JAsr7quIjuU4Zao2uQlBlA+XFXPIu3R9bHRiD1MbbCspu/qOfZzFbHgk5hLXScmUIY22MUoTk4s8A/Q5yLMRIkoIPQxXj5kHpxRGFgy0dT1YAbvKxYIJRv9jVRNyHBfopirxAbRR1hQyIUyhxiow8MMBn2BbrKabPDpcKgJrYvDDuvY66rkb9I1wQVOzohU6pt0sbOXSNNYXcAYP0gHDbtQX1+C3hM8zV0jkbA=
3f89672a-c524-418f-8819-e0c0ff12d240	d43afdc3-b138-43b6-861c-45ec6f454fbb	priority	100
3166e2fa-0688-4f0c-8485-ce51b84a1942	d1484629-ec94-4046-8b44-a1a2e9a77ae4	allowed-protocol-mapper-types	saml-user-attribute-mapper
6cc4267a-14dc-4611-bf02-4508f2806956	d1484629-ec94-4046-8b44-a1a2e9a77ae4	allowed-protocol-mapper-types	oidc-full-name-mapper
0dd2a76a-a456-4a25-a507-24c7ac6ab423	d1484629-ec94-4046-8b44-a1a2e9a77ae4	allowed-protocol-mapper-types	saml-role-list-mapper
ad2f0cb4-add7-4593-a77a-1c857b28b8a9	d1484629-ec94-4046-8b44-a1a2e9a77ae4	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
b64d2bdd-9a1d-487b-90d6-0335c2e6bf9d	d1484629-ec94-4046-8b44-a1a2e9a77ae4	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
eff8228f-8252-4355-907b-3863260f5081	d1484629-ec94-4046-8b44-a1a2e9a77ae4	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
942fb556-7180-44e6-9b10-b80aece1070a	d1484629-ec94-4046-8b44-a1a2e9a77ae4	allowed-protocol-mapper-types	oidc-address-mapper
c557fb69-1f18-4505-bf3a-0696c6d9a123	d1484629-ec94-4046-8b44-a1a2e9a77ae4	allowed-protocol-mapper-types	saml-user-property-mapper
25cc7759-d894-4b97-9b4c-a4b2fabfb610	e8d38bae-a0aa-4cc5-8502-e0ebc0ae7fdd	host-sending-registration-request-must-match	true
14d23b8e-754d-44af-8479-1c22a81546ca	e8d38bae-a0aa-4cc5-8502-e0ebc0ae7fdd	client-uris-must-match	true
9b58361a-3ec2-48c2-b303-9171c866cc94	d04d4205-3801-4609-b39b-a71b870ab65c	max-clients	200
031021f2-2eb1-4fa7-a897-bf0be0c2c8b2	06b7ac66-cff3-4f32-9d05-6191c295d747	privateKey	MIIEowIBAAKCAQEAuPDJPD8HJJ43qw27R+HdsNvLC4HzL+yfRX3S2r5146rH0CdaI3uvx64LIBl2xrVamryY7nRD8vZpUsCvyxVCSFFsSbAigJza7/YUvVahhKkY2bot3lCWnZsx2OKECrdtWPpfBpKTDtz/cCn832Ryqpr+ZJmfB8mWOOJpEOE8hZ3RMTq9n8gydHq0pc1NwzHaj1OOrGdfMYF5rypBqc4B81t+zU0P9RJimZTXoj0E0o6Pz672yDoAfyeCUZ2HK96dm5dkmacCrSmv8AvvjeuO98Al1S/WlJinBeC/EUqyBMEmLWCD1wq+in93lHxfEzU9XdP/IsLJcIUpT/6PrLxw0wIDAQABAoIBAAqJtQjvSHXQMOwL9MHUTDPUwLcvpbVAROHXTEMox7V7/wJ/2e8cQzhcCCGnzpcYMO9doFMzocZZPxTqVzn5qwfm4WygRV8E6qUlfvbVvFwl37CF6/4qb/w1olUxSjfRtHPcLe6SCu1PL2jrPSlXfM2Qb/I4hKstBxfHr7GFom0a9H55V3vpD5nPIxhPGRpJFAcs9pWhGHoiY00I0KRmY08IG71Gchvj24MeCp7PAlihdf8PwV04rpur+d6M2rgOMEH1q1NqHBB/LGAe4po1YsdAT71ReOHTOg6O8pPv+yoOekVMqm6mqHnNbq1m/ZKQ4l6nnNWhr1RM4936dDNANa0CgYEA2d9W5RjJjByzZnuLyVsV8CnEwNSjnnmVPJB+zIgFDAPmHX/t4GtHqEfSVUtsjQbGTJJViDDZNFXE14yyq42rDFB5F9NVxHOkIjujZtvgVbfDuoY3w0mHvQEtXwP4Fyo/L1iKMyKUjl5r0pe/5q/+GbAvTujJ9Mr6sQCUjXLpwj0CgYEA2U4aeOXyAflJ1M0j02i4cXwiFmhMOOCVmuSRxady6xpBYlToKfSdUxYLvhEGUCfSa6MEjAzpBLw+AHIfnnCj4M439CSKvZAN7eSOaIYPhBgksDBtdbWFwFv7oNfYxWw8eC4XcGcrBipJdCIus/a0aXMWAiNh2chGlV9Nq4oXgE8CgYA0Hses2rcse5k3RQr1yoJ/B573+maB/NgEuxR6XXfHng8os3f2nfNwgG4C1Z5MRnidzMwFXpo3eOU0I4aCn8txkLbHSllUO83iGp5Gdwc9uk5qir1ATJDaWDPAbTSmZgbjjqzQ+s7LGC93G7Jev29sOce3et0FYKGEQn1HMVxWiQKBgQCrgf5YvzvjnOpNv17wQ22XfB63SrgmB/Nr3czDkGad8gn63wKh4oOtCPBZobw21Uc5Vt+G3cWnzB6vYWNdPI/LJVd6JMEv3htwT/ypuG1Ul22VdZNe3NbkvHR8PP/EyalsPQyY1YRaiFOTCkuMFEHOHFwZce2P4ob66840fngP9wKBgEapt1fgd3eFxW/0OjEaa9IC7LSRcih0YaWAuTdxIsOhywWUSR2ToC9u8XaBpFji0T7CvbyA6qvFVbzDx/rEkPwUAJqyFe60saoBAghMgboGlbjdSmUOh68KPDJKKAbUYeNncRriFQpcR7QBJsozHaMcuJtfJ/4Jt8z/25AM4KZG
513eb9b8-a692-4e20-8c39-52fd2354d030	06b7ac66-cff3-4f32-9d05-6191c295d747	keyUse	SIG
2c0b4a80-7f65-494f-b42b-140ffe714aef	06b7ac66-cff3-4f32-9d05-6191c295d747	priority	100
5e8d47c6-33fc-42ad-b41c-4453ce9735fb	06b7ac66-cff3-4f32-9d05-6191c295d747	certificate	MIICnTCCAYUCBgGEPjKkxzANBgkqhkiG9w0BAQsFADASMRAwDgYDVQQDDAdleGFtcGxlMB4XDTIyMTEwMzE1NTE1N1oXDTMyMTEwMzE1NTMzN1owEjEQMA4GA1UEAwwHZXhhbXBsZTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALjwyTw/BySeN6sNu0fh3bDbywuB8y/sn0V90tq+deOqx9AnWiN7r8euCyAZdsa1Wpq8mO50Q/L2aVLAr8sVQkhRbEmwIoCc2u/2FL1WoYSpGNm6Ld5Qlp2bMdjihAq3bVj6XwaSkw7c/3Ap/N9kcqqa/mSZnwfJljjiaRDhPIWd0TE6vZ/IMnR6tKXNTcMx2o9TjqxnXzGBea8qQanOAfNbfs1ND/USYpmU16I9BNKOj8+u9sg6AH8nglGdhyvenZuXZJmnAq0pr/AL743rjvfAJdUv1pSYpwXgvxFKsgTBJi1gg9cKvop/d5R8XxM1PV3T/yLCyXCFKU/+j6y8cNMCAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAL7VDBdw6OhAE29p+EYWlNa1cx/efBOMj9EOU4p37tmuGWIwuNtIZ3ZpcM9ZH1GcVp0GUTgTfk4KQdPNXkjO5NxQdOQx9h2K0HBR1o2MNqL0Nqk+pKAzgKssgYx4+zpnzXx5VpuT0e+ckAg8ZxEzvTeKm8Bjd5a7483mu7tzBZk78ZYA0+h94Nh7CAeTMUli9S3R+rIOdV2oCK9rkUyc9+8XWwkUDvIBI4hTlNh2V+hqWup5mS0m1EfybZXr6xIMam3oI0MmexQYAPwLg5xfcYnDEuws7i70LLNrIg7q7YnMekYlyBlhYcwBDXmAOMwnTUTUDjPQBwe+3U3hng+gJ6A==
8e1fbd93-fc6c-482b-bf9a-e20a87500c53	080cea4f-3e51-475c-b159-d3626379c0ac	allow-default-scopes	true
43a17a0f-5261-4d68-a262-951fbba4ffe2	bfbb1e13-7894-4c15-b817-4e8ca7d0241e	algorithm	HS512
bb4202b5-4c8a-48d5-9fdb-fb0629a420ac	34d468f5-42f5-40c4-89b4-492e9dde841b	allowed-protocol-mapper-types	saml-user-property-mapper
d67726bd-a1cf-436a-b26c-c47e001bb050	34d468f5-42f5-40c4-89b4-492e9dde841b	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
4d0e44ca-23aa-4e30-88bf-1920dd0f8c3b	8c88c66a-57e3-483f-acc5-f32e558a0f19	allow-default-scopes	true
57ad6578-d5b3-448d-8f52-4882777d65e3	43b06b3a-da47-4411-ace1-9e2f5d3a8aa3	privateKey	MIIEpQIBAAKCAQEAycr7mbQQ/IJF1tWKCX46IP7lpmNGDra+MJaNPLyepyQR6QHXzHMJSDAt0Tj7X94d8bJ+hZASNWeCtXQizXrYPZYvm+coj8lQDru6tZxRTA4JCg69mXdtRm9fynEY2aRjXbwyx/JYdnVOT16YgK4xZKpSfKJfGXeewnS6yeMw2/dkJvW7Mkp3wRfyla3zeygAxGxE8lOnP3kodOO+HfxS4U6LX4MglAVb99JgN9bCXySXdefNwjB9gbFKxCPLVjMFns0EDSbb00VQ8XCYx2IQRJxOw/TBpEHldC3VCboTKKYnXPlEuMBgQMii+1BS3Xr28sQiwmrCqE1WD96sTtsEHwIDAQABAoIBABjwn+5WvXS1QHQgDz/uHGQV7NncJ31LuQTgo+hvotIjLfLU5KV4SvDjl34QzgICve5bMlzyj0rkwK20LVWlCv3Nm+kSWvEudIO6+wVVd7dv0qPYv4vXS/z/veCTis/iC9qQFzH0HK/YqWA7ikX5LCdLZQd8upviAg/5hQPNCFhfKldG1B8Ufsq8Zfw3MfUqBynVEA6DWF7mgZls4soSK42sdlsVp+rA2B26P7fCWglHega2PaUhIZBgILhz0qqsj+gyJrUo33MmoCwepqdz+KVaHuJlU03ym3l8uhaGQoAqLPlHTQRTHoFOeGjWnNaEOUItDUOf38yF17l2OsYCLrECgYEA7b31ojGqfn3tsq7DJOMocDc6QakuRYS/niYeHp0HuwHNE/s13DwHSuO9zntrIDJsrtnSgWJrpUZWBJyoWLIca43PDEeEdpG8BkyoCeMJu2U7A4mzjDLGh4R9/95hoVymFRDNYBGuxxsCkBa+utL/0f22Kf3+7QHB745eAT1CtxECgYEA2UpCMt6GJ+0Mslj3Li3DB5PMjqCJ4BoSenhe4zhWbgAnX6uaiY1jGR1Rl0Lv2Jx1pKQlDDatnnTmJASFEWVcGZY2iiYThjbw1kpdjH3vB3R7RX2Zf3cpxN9oq5r0dEUPVn5KC81915uZooEQJyWffh1QyFeJHUL0xABaZEZ06C8CgYEAsE4UD+EXF9EZak4R55QR1A4QxMrKxsEoPQb1hSxcpEE0rWG5UoatvcrgYnTCP9FFKfHdGxg6zgk4Fxl5+rSzQMucRPXwdOGkd2N3pkVZXUA4IGqI3Sp2cd8+dXacHkcP30VjmJ/kZkFQiDxl2zRIhJjK858p4udPw/BnJDIi/JECgYEAkyxV3CiWS1Kmx+G0QgXi1C4KXgxkdnKSU3tWIaaV+9mE0arkeAhYt7kA+2fuFhQbJpG7OiOKwwnAm2KoUpkJoZb5h+a0ULLDuxERfcgKb0049V9V6Vzn4J3FQn4o1tuzwMy3EHl1o+STUdsC+tDjz0LB5YBMsZIZQOxQTRzfsCcCgYEApm90jLMroK/bBBJx+7B+K+uaHgbdRfvzY531Ji5EMrivNZ9HngvmWXAFI02kxr3wIZruq2F6DfVTw6lrzKj/JDUuwpH/42kvTReOXAEZDyW9oDo5bWgVrTZ1JR51xY5CWmTRUpdv1MI7tcxWi/BZRiXoFu6pLMmn7o2M5NmbgCM=
ab183893-41e2-4400-91b4-f87f88df1c88	43b06b3a-da47-4411-ace1-9e2f5d3a8aa3	algorithm	RSA-OAEP
ad1a7126-de8a-49f3-af2f-d9be9bd45fa4	43b06b3a-da47-4411-ace1-9e2f5d3a8aa3	keyUse	ENC
7f5c6f62-1c96-4eaf-86e4-52e005b3de4f	43b06b3a-da47-4411-ace1-9e2f5d3a8aa3	certificate	MIICnTCCAYUCBgGEPjKlOjANBgkqhkiG9w0BAQsFADASMRAwDgYDVQQDDAdleGFtcGxlMB4XDTIyMTEwMzE1NTE1N1oXDTMyMTEwMzE1NTMzN1owEjEQMA4GA1UEAwwHZXhhbXBsZTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMnK+5m0EPyCRdbVigl+OiD+5aZjRg62vjCWjTy8nqckEekB18xzCUgwLdE4+1/eHfGyfoWQEjVngrV0Is162D2WL5vnKI/JUA67urWcUUwOCQoOvZl3bUZvX8pxGNmkY128MsfyWHZ1Tk9emICuMWSqUnyiXxl3nsJ0usnjMNv3ZCb1uzJKd8EX8pWt83soAMRsRPJTpz95KHTjvh38UuFOi1+DIJQFW/fSYDfWwl8kl3XnzcIwfYGxSsQjy1YzBZ7NBA0m29NFUPFwmMdiEEScTsP0waRB5XQt1Qm6EyimJ1z5RLjAYEDIovtQUt169vLEIsJqwqhNVg/erE7bBB8CAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAxhZeaOaSHmWdUlL8SnJ/RElSMxqBCcSMP5SDljhWWoZLxoblfczSc04nmgPHW4l+YJCbEZIudKB+1/3cVgZ96Qy+IvdYBjKwQa+Vca6lw9QUplOAt9IeurEXuSiAYdaEGtg+RriQ27foDc7INy8AGgOiY7/QyHli5UP3VBlqobJljPz15xAArZxX7uwbpdPUBKxI7LgexIPm1NhLt8udJMppudkO169rnjab+Z/bYGNFfh7hnM5sNDSWgj78R04hSK6Dv6f/+8MRIRolSdb5S15y0PQbPlN4FY8nqD8GP3xFv/cL52WlokKCYSRsmsdzBfecPTr7h68xCfJA3lwkfQ==
5ff3fcb0-df0a-4795-b3a5-75dc5a628c4c	43b06b3a-da47-4411-ace1-9e2f5d3a8aa3	priority	100
9c25f820-4ef1-4319-b88c-00fc9d9b7d54	70eb8616-ff4c-4c5b-b3b7-9dd78795b626	kid	bbcf3bfc-9f4e-45d5-a4c0-06606cd8d9d1
c93f1429-8d05-4b5d-8cb8-7bea433d6abf	70eb8616-ff4c-4c5b-b3b7-9dd78795b626	secret	1cdUiviXMwATbXwDRmUKqw
c88a1457-b693-4fa4-9558-3116adc92895	70eb8616-ff4c-4c5b-b3b7-9dd78795b626	priority	100
5da62548-d1d5-4d13-9152-bb35b94f028c	417d29a2-dfe3-479b-ae51-25454014cb58	secret	oR-KUB5q-FekSsJXHseZoz576qT-LxitOi3wvO8nEx9ZPAlIk4yvy7j7lzO-l59Cr7NylxqT0-VPxQuyVmYj_A
0dd87f27-3fc8-47f8-be65-95f21e2ad157	417d29a2-dfe3-479b-ae51-25454014cb58	priority	100
8aa91b35-11e2-4b78-a744-041f0e913b9f	417d29a2-dfe3-479b-ae51-25454014cb58	kid	128fdf01-f222-4f66-a926-685655212115
b9c62526-dff6-48ef-8880-6fe6f82b8522	417d29a2-dfe3-479b-ae51-25454014cb58	algorithm	HS256
5217d35b-b752-466c-b2a4-e1876604877e	cca146f3-c7a6-4ea6-9c4f-5aea87d9e68b	kc.user.profile.config	{"attributes":[{"name":"username","displayName":"${username}","validations":{"length":{"min":3,"max":255},"username-prohibited-characters":{},"up-username-not-idn-homograph":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"email","displayName":"${email}","validations":{"email":{},"length":{"max":255}},"required":{"roles":["user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"firstName","displayName":"${firstName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"required":{"roles":["user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"lastName","displayName":"${lastName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"required":{"roles":["user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false}],"groups":[{"name":"user-metadata","displayHeader":"User metadata","displayDescription":"Attributes, which refer to user metadata"}],"unmanagedAttributePolicy":"ENABLED"}
29d584c6-3d38-4eab-b7b9-31950006f3d9	08e57fa6-b1ce-4d7d-b19c-033c04c19a14	kid	5f80b959-9562-4b93-8080-695e2dcc7afb
dd28baea-7137-4365-818c-8712d8fef419	08e57fa6-b1ce-4d7d-b19c-033c04c19a14	priority	100
a8c42113-fba8-43b2-a9df-af9628127882	08e57fa6-b1ce-4d7d-b19c-033c04c19a14	algorithm	HS512
89974273-df9d-457b-ba1d-0b38e2b4e001	08e57fa6-b1ce-4d7d-b19c-033c04c19a14	secret	k_QFjR8A3-tNzLoub75WiF9inWF2s8vJnkHjcyMwUbYR0Jn7Vqy5L6quLpw4RKyJ7wcZLf4icNYB1KWkRf7CONZMXuFWYPlbE4s0Y8Z6IuBCCAr5-2903L2MAtWBpw7jE7vzaD3GbXj_vXaEx_gNJ3jZvrSnOag29G8cJSefW6Y
3bc31d02-4935-4c68-8463-778b2eacfa4a	bfbb1e13-7894-4c15-b817-4e8ca7d0241e	priority	100
27c2a760-eb1d-4db8-a619-9dca9560667b	bfbb1e13-7894-4c15-b817-4e8ca7d0241e	secret	V-XL6-NYhw1Q8M56rb2juGW7dL1KNKwPX3KAVdmDoeBiT9F7dNOUJlhBE07rmf8K6Uhj23kdzRxV5e-GaiEM4DiK5QOpiCucDtEk6a8-nTlog3tmyZCAQT6wsG3t5mJiSM-D-ey7IKHlhfUCjtCjOkzqyMDvUnxwTp6XsenZBGE
33207385-3db1-4889-89a5-fa0e7b911375	bfbb1e13-7894-4c15-b817-4e8ca7d0241e	kid	22a22649-aac1-4f81-86a7-b3ba4824b955
d8e060ac-b4c0-4573-b17b-f8455d6f413c	37099f6d-8da7-4eda-9070-fd1dacbc3202	kc.user.profile.config	{"attributes":[{"name":"username","displayName":"${username}","validations":{"length":{"min":3,"max":255},"username-prohibited-characters":{},"up-username-not-idn-homograph":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"email","displayName":"${email}","validations":{"email":{},"length":{"max":255}},"required":{"roles":["user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"firstName","displayName":"${firstName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"required":{"roles":["user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"lastName","displayName":"${lastName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"required":{"roles":["user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false}],"groups":[{"name":"user-metadata","displayHeader":"User metadata","displayDescription":"Attributes, which refer to user metadata"}],"unmanagedAttributePolicy":"ENABLED"}
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.composite_role (composite, child_role) FROM stdin;
742fe314-bb0a-4e40-acea-9a4ab20bf605	469c5ad7-a51f-4492-9f64-d17b7ae6953e
742fe314-bb0a-4e40-acea-9a4ab20bf605	0d5c9c1b-5ca4-4059-9a00-6e54f3ce0084
742fe314-bb0a-4e40-acea-9a4ab20bf605	f3fd4706-f990-4831-b2cc-428f5ffcf492
742fe314-bb0a-4e40-acea-9a4ab20bf605	5d5955c6-2aab-4aaf-bc7c-5b2cc6d5bc10
742fe314-bb0a-4e40-acea-9a4ab20bf605	f3f6f88b-fd04-498c-ae6b-c658f7a56755
742fe314-bb0a-4e40-acea-9a4ab20bf605	8ee32bee-9aca-4f75-b878-8fa7b6576571
742fe314-bb0a-4e40-acea-9a4ab20bf605	14945a4c-5363-48dc-b539-fe301dc02621
742fe314-bb0a-4e40-acea-9a4ab20bf605	b2d01646-edb9-40c6-9a98-5c27a408e0b6
742fe314-bb0a-4e40-acea-9a4ab20bf605	4d9be543-1691-4bf0-8c5a-8bbba0d413df
742fe314-bb0a-4e40-acea-9a4ab20bf605	f6828e21-ab2a-4673-9a98-905fc674437f
742fe314-bb0a-4e40-acea-9a4ab20bf605	366e1fc0-db07-4bc0-a9bc-4ac401d62e23
742fe314-bb0a-4e40-acea-9a4ab20bf605	003c1039-9b8c-44c1-af3a-abd17b8803e0
742fe314-bb0a-4e40-acea-9a4ab20bf605	fd8ecca4-8e6e-4ffa-8a2a-524aea724c10
742fe314-bb0a-4e40-acea-9a4ab20bf605	bfe597b8-3faf-457c-bdfe-5c15d19fe6b2
742fe314-bb0a-4e40-acea-9a4ab20bf605	ebf19b3d-5f55-4f0d-b20c-a4a63546304e
742fe314-bb0a-4e40-acea-9a4ab20bf605	abfac688-c89e-4c02-ac0b-d6570590fa73
742fe314-bb0a-4e40-acea-9a4ab20bf605	596feaa4-a1bb-4352-b74b-f07f7129b9ec
742fe314-bb0a-4e40-acea-9a4ab20bf605	f4c1af3b-38a2-437a-8225-e71d722dc0ea
137b4a16-e5b8-4ac6-9ca3-0121e1f66f4e	92caaa7c-167f-4e22-acb1-5657a5731add
5d5955c6-2aab-4aaf-bc7c-5b2cc6d5bc10	ebf19b3d-5f55-4f0d-b20c-a4a63546304e
5d5955c6-2aab-4aaf-bc7c-5b2cc6d5bc10	f4c1af3b-38a2-437a-8225-e71d722dc0ea
f3f6f88b-fd04-498c-ae6b-c658f7a56755	abfac688-c89e-4c02-ac0b-d6570590fa73
137b4a16-e5b8-4ac6-9ca3-0121e1f66f4e	78d73956-992b-423b-8955-bc8b1cc11b5e
78d73956-992b-423b-8955-bc8b1cc11b5e	0becb182-81a3-4676-870f-608a56cc5cb7
90f44e44-3321-4d07-9dd0-fe13c764d389	24dc1534-6cc0-412c-964b-3eedc980623a
742fe314-bb0a-4e40-acea-9a4ab20bf605	84f0c80e-199d-4320-9e11-6b8dc939d773
137b4a16-e5b8-4ac6-9ca3-0121e1f66f4e	839a4ab2-997d-42e3-8a08-9a06a8a393e4
137b4a16-e5b8-4ac6-9ca3-0121e1f66f4e	039f9dd6-880c-4596-9e09-b7a42d8acb6a
742fe314-bb0a-4e40-acea-9a4ab20bf605	ee8056eb-d725-424b-abc5-b0eea6e9a609
742fe314-bb0a-4e40-acea-9a4ab20bf605	1f5084bd-0d07-4c35-b287-9faed54987b2
742fe314-bb0a-4e40-acea-9a4ab20bf605	65bfcedf-0f48-4bf7-919d-c5af4b2eb532
742fe314-bb0a-4e40-acea-9a4ab20bf605	ee26c12b-e8d9-4a2b-a43e-10e64ddf9476
742fe314-bb0a-4e40-acea-9a4ab20bf605	dccc011c-a5a3-4e29-a87a-7d83566e59b8
742fe314-bb0a-4e40-acea-9a4ab20bf605	537004e9-5509-470e-9cc8-28f4d7f841b9
742fe314-bb0a-4e40-acea-9a4ab20bf605	4a3b6893-2b09-4840-8896-4dcda2bb5f72
742fe314-bb0a-4e40-acea-9a4ab20bf605	2b0e54e9-ae19-4af6-9616-fcd765b3ad23
742fe314-bb0a-4e40-acea-9a4ab20bf605	822b79ed-05a3-4c63-8bfb-ff6bf40e45c3
742fe314-bb0a-4e40-acea-9a4ab20bf605	5f11a15b-7e09-4a9f-8d98-f4d6e9f28576
742fe314-bb0a-4e40-acea-9a4ab20bf605	1d4c7081-f6a5-46e5-a338-754138a917fc
742fe314-bb0a-4e40-acea-9a4ab20bf605	e3afbad0-dc35-4e16-97f9-37d276c68906
742fe314-bb0a-4e40-acea-9a4ab20bf605	b9d1e31e-5ddb-4436-938b-9f1c4d530804
742fe314-bb0a-4e40-acea-9a4ab20bf605	ff85a43f-2994-48a1-9289-e016fdd036f2
742fe314-bb0a-4e40-acea-9a4ab20bf605	526a9e15-dbd3-40aa-ad65-6d6441e66bbf
742fe314-bb0a-4e40-acea-9a4ab20bf605	10044ebb-0d89-495f-97d0-bc4efcf7bf73
742fe314-bb0a-4e40-acea-9a4ab20bf605	67d973d1-3695-408e-ad5b-bbf5551a43c0
65bfcedf-0f48-4bf7-919d-c5af4b2eb532	ff85a43f-2994-48a1-9289-e016fdd036f2
65bfcedf-0f48-4bf7-919d-c5af4b2eb532	67d973d1-3695-408e-ad5b-bbf5551a43c0
ee26c12b-e8d9-4a2b-a43e-10e64ddf9476	526a9e15-dbd3-40aa-ad65-6d6441e66bbf
1e8d1e98-4d95-4043-bee8-ee5db23ba73a	5cac6c81-3400-4661-a5d6-a7bf50604118
2d4a63df-b516-4663-8eb3-2bb54255b970	a0810f98-b38d-44c0-a28a-9d3ed868c52d
2d4a63df-b516-4663-8eb3-2bb54255b970	6b1873ae-f97e-40e8-8c16-a85559b784ab
2d4a63df-b516-4663-8eb3-2bb54255b970	ed2d2483-278c-48da-84d1-636df5351394
2d4a63df-b516-4663-8eb3-2bb54255b970	d61f4850-64ba-42d5-8790-190dfc3016b3
429cc12d-78fc-45b9-a420-1a8ee239ade8	ba11bfa0-990d-4516-a0c7-d4fcc9e8e74b
429cc12d-78fc-45b9-a420-1a8ee239ade8	44a267e0-bdb6-488c-a9a3-c6ae9af8b2d9
48ac17ff-1e6c-44d4-b77b-2444b74da7d9	23bb30ca-527e-44b9-8d7f-97be52f9eefd
48ac17ff-1e6c-44d4-b77b-2444b74da7d9	c967e37c-9868-40df-80ef-b2759f98ce99
48ac17ff-1e6c-44d4-b77b-2444b74da7d9	c6d618c2-0218-4277-ac7a-184f9a81d91d
48ac17ff-1e6c-44d4-b77b-2444b74da7d9	b0d2ea45-0be6-4ece-835b-5f4cbfff8afb
48ac17ff-1e6c-44d4-b77b-2444b74da7d9	b4f3e6be-6a29-4f4e-a994-c66d190c7040
48ac17ff-1e6c-44d4-b77b-2444b74da7d9	39a130ef-0898-4859-903c-e1251cbf74e6
48ac17ff-1e6c-44d4-b77b-2444b74da7d9	f89343c0-2fcd-42d3-9692-f33d6b335342
48ac17ff-1e6c-44d4-b77b-2444b74da7d9	2dc77f93-9086-4191-b0c4-4b629b3a175c
48ac17ff-1e6c-44d4-b77b-2444b74da7d9	5818b0d5-07bc-4aab-9d81-6b6d25715251
48ac17ff-1e6c-44d4-b77b-2444b74da7d9	2f4e3173-9aa6-4ea2-94eb-91c9796a2065
48ac17ff-1e6c-44d4-b77b-2444b74da7d9	e7ac2ec4-38b8-4241-8d4b-3ad65e29991a
48ac17ff-1e6c-44d4-b77b-2444b74da7d9	af1675b5-beec-4448-a09d-53524bcef6bf
48ac17ff-1e6c-44d4-b77b-2444b74da7d9	a055025c-b805-446f-9e31-1836e3afc34e
48ac17ff-1e6c-44d4-b77b-2444b74da7d9	ba11bfa0-990d-4516-a0c7-d4fcc9e8e74b
48ac17ff-1e6c-44d4-b77b-2444b74da7d9	9fbaa847-f9e6-49ff-9ee5-e605eac8cfd2
48ac17ff-1e6c-44d4-b77b-2444b74da7d9	05070aea-a2af-4faa-bfed-2cd497bcdeca
48ac17ff-1e6c-44d4-b77b-2444b74da7d9	429cc12d-78fc-45b9-a420-1a8ee239ade8
48ac17ff-1e6c-44d4-b77b-2444b74da7d9	44a267e0-bdb6-488c-a9a3-c6ae9af8b2d9
6b1873ae-f97e-40e8-8c16-a85559b784ab	ce5401bb-db61-4722-a671-98725d7c676a
b4f3e6be-6a29-4f4e-a994-c66d190c7040	af1675b5-beec-4448-a09d-53524bcef6bf
742fe314-bb0a-4e40-acea-9a4ab20bf605	b382a4b6-fb8b-4f69-bf12-e70b99d138aa
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
2856d8da-792b-4668-834e-4a35f9602ca3	\N	password	24337354-76d5-4bac-ad84-9d40a29cfa3b	1667491153085	My password	{"value":"OPkBq0Krvj/QSnZZg10IFcr2nbc/tQ+l9D3o3CxSxNB4zgyNBgo4pPXZ88hmqqE2cJqF1JUkC9n35zcpaD2Yiw==","salt":"ksFKPcEhYxUPGkxs3THZ0Q==","additionalParameters":{}}	{"hashIterations":210000,"algorithm":"pbkdf2-sha512","additionalParameters":{}}	10
d2341c2d-65b9-4d28-9761-95e42c73efb0	\N	password	830d4527-c9c9-41c3-8635-0d9af99ab116	1717782418647	\N	{"value":"fWno5hYw5GXQPo9OXn7LLRkDmmr5q2LEs6zSAfz+4pzvx1CGZRVHjZQOqd+SSgMmPonm6jZuu7yJV12QSXmOAQ==","salt":"0HdNZVb7HhTjlXF8KEUEgw==","additionalParameters":{}}	{"hashIterations":210000,"algorithm":"pbkdf2-sha512","additionalParameters":{}}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-11-14 11:25:31.710899	49	EXECUTED	9:d198654156881c46bfba39abd7769e69	addColumn tableName=REALM		\N	4.8.0	\N	\N	8425129015
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2022-11-14 11:25:29.720893	1	EXECUTED	9:6f1016664e21e16d26517a4418f5e3df	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.8.0	\N	\N	8425129015
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2022-11-14 11:25:29.730692	2	MARK_RAN	9:828775b1596a07d1200ba1d49e5e3941	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.8.0	\N	\N	8425129015
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2022-11-14 11:25:29.804105	3	EXECUTED	9:5f090e44a7d595883c1fb61f4b41fd38	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	4.8.0	\N	\N	8425129015
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2022-11-14 11:25:29.807367	4	EXECUTED	9:c07e577387a3d2c04d1adc9aaad8730e	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	4.8.0	\N	\N	8425129015
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2022-11-14 11:25:30.053393	5	EXECUTED	9:b68ce996c655922dbcd2fe6b6ae72686	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.8.0	\N	\N	8425129015
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2022-11-14 11:25:30.056277	6	MARK_RAN	9:543b5c9989f024fe35c6f6c5a97de88e	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.8.0	\N	\N	8425129015
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2022-11-14 11:25:31.86265	55	EXECUTED	9:db806613b1ed154826c02610b7dbdf74	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	4.8.0	\N	\N	8425129015
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2022-11-14 11:25:30.227005	7	EXECUTED	9:765afebbe21cf5bbca048e632df38336	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.8.0	\N	\N	8425129015
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2022-11-14 11:25:30.229885	8	MARK_RAN	9:db4a145ba11a6fdaefb397f6dbf829a1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.8.0	\N	\N	8425129015
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2022-11-14 11:25:30.23505	9	EXECUTED	9:9d05c7be10cdb873f8bcb41bc3a8ab23	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	4.8.0	\N	\N	8425129015
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2022-11-14 11:25:30.491849	10	EXECUTED	9:18593702353128d53111f9b1ff0b82b8	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	4.8.0	\N	\N	8425129015
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2022-11-14 11:25:30.601233	11	EXECUTED	9:6122efe5f090e41a85c0f1c9e52cbb62	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.8.0	\N	\N	8425129015
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2022-11-14 11:25:30.60358	12	MARK_RAN	9:e1ff28bf7568451453f844c5d54bb0b5	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.8.0	\N	\N	8425129015
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2022-11-14 11:25:30.622116	13	EXECUTED	9:7af32cd8957fbc069f796b61217483fd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.8.0	\N	\N	8425129015
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2022-11-14 11:25:30.661176	14	EXECUTED	9:6005e15e84714cd83226bf7879f54190	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	4.8.0	\N	\N	8425129015
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2022-11-14 11:25:30.662746	15	MARK_RAN	9:bf656f5a2b055d07f314431cae76f06c	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	8425129015
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2022-11-14 11:25:30.664266	16	MARK_RAN	9:f8dadc9284440469dcf71e25ca6ab99b	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	4.8.0	\N	\N	8425129015
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2022-11-14 11:25:30.665775	17	EXECUTED	9:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.8.0	\N	\N	8425129015
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2022-11-14 11:25:30.769353	18	EXECUTED	9:3368ff0be4c2855ee2dd9ca813b38d8e	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	4.8.0	\N	\N	8425129015
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2022-11-14 11:25:30.848598	19	EXECUTED	9:8ac2fb5dd030b24c0570a763ed75ed20	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.8.0	\N	\N	8425129015
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2022-11-14 11:25:30.852676	20	EXECUTED	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.8.0	\N	\N	8425129015
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2022-11-14 11:25:30.854504	21	MARK_RAN	9:831e82914316dc8a57dc09d755f23c51	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.8.0	\N	\N	8425129015
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2022-11-14 11:25:30.861373	22	MARK_RAN	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.8.0	\N	\N	8425129015
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2022-11-14 11:25:30.893208	23	EXECUTED	9:bc3d0f9e823a69dc21e23e94c7a94bb1	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	4.8.0	\N	\N	8425129015
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2022-11-14 11:25:30.896775	24	EXECUTED	9:c9999da42f543575ab790e76439a2679	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.8.0	\N	\N	8425129015
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2022-11-14 11:25:30.898233	25	MARK_RAN	9:0d6c65c6f58732d81569e77b10ba301d	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.8.0	\N	\N	8425129015
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2022-11-14 11:25:30.94765	26	EXECUTED	9:fc576660fc016ae53d2d4778d84d86d0	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	4.8.0	\N	\N	8425129015
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2022-11-14 11:25:31.108833	27	EXECUTED	9:43ed6b0da89ff77206289e87eaa9c024	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	4.8.0	\N	\N	8425129015
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2022-11-14 11:25:31.113632	28	EXECUTED	9:44bae577f551b3738740281eceb4ea70	update tableName=RESOURCE_SERVER_POLICY		\N	4.8.0	\N	\N	8425129015
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2022-11-14 11:25:31.251635	29	EXECUTED	9:bd88e1f833df0420b01e114533aee5e8	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	4.8.0	\N	\N	8425129015
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2022-11-14 11:25:31.280963	30	EXECUTED	9:a7022af5267f019d020edfe316ef4371	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	4.8.0	\N	\N	8425129015
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2022-11-14 11:25:31.306424	31	EXECUTED	9:fc155c394040654d6a79227e56f5e25a	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	4.8.0	\N	\N	8425129015
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2022-11-14 11:25:31.311013	32	EXECUTED	9:eac4ffb2a14795e5dc7b426063e54d88	customChange		\N	4.8.0	\N	\N	8425129015
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2022-11-14 11:25:31.315299	33	EXECUTED	9:54937c05672568c4c64fc9524c1e9462	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	8425129015
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2022-11-14 11:25:31.316741	34	MARK_RAN	9:3a32bace77c84d7678d035a7f5a8084e	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.8.0	\N	\N	8425129015
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2022-11-14 11:25:31.36228	35	EXECUTED	9:33d72168746f81f98ae3a1e8e0ca3554	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.8.0	\N	\N	8425129015
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2022-11-14 11:25:31.365664	36	EXECUTED	9:61b6d3d7a4c0e0024b0c839da283da0c	addColumn tableName=REALM		\N	4.8.0	\N	\N	8425129015
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2022-11-14 11:25:31.373453	37	EXECUTED	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	8425129015
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2022-11-14 11:25:31.376316	38	EXECUTED	9:a2b870802540cb3faa72098db5388af3	addColumn tableName=FED_USER_CONSENT		\N	4.8.0	\N	\N	8425129015
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2022-11-14 11:25:31.379432	39	EXECUTED	9:132a67499ba24bcc54fb5cbdcfe7e4c0	addColumn tableName=IDENTITY_PROVIDER		\N	4.8.0	\N	\N	8425129015
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2022-11-14 11:25:31.380901	40	MARK_RAN	9:938f894c032f5430f2b0fafb1a243462	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	4.8.0	\N	\N	8425129015
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2022-11-14 11:25:31.382391	41	MARK_RAN	9:845c332ff1874dc5d35974b0babf3006	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	4.8.0	\N	\N	8425129015
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2022-11-14 11:25:31.38624	42	EXECUTED	9:fc86359c079781adc577c5a217e4d04c	customChange		\N	4.8.0	\N	\N	8425129015
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2022-11-14 11:25:31.612579	43	EXECUTED	9:59a64800e3c0d09b825f8a3b444fa8f4	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	4.8.0	\N	\N	8425129015
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2022-11-14 11:25:31.615415	44	EXECUTED	9:d48d6da5c6ccf667807f633fe489ce88	addColumn tableName=USER_ENTITY		\N	4.8.0	\N	\N	8425129015
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-11-14 11:25:31.618737	45	EXECUTED	9:dde36f7973e80d71fceee683bc5d2951	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	4.8.0	\N	\N	8425129015
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-11-14 11:25:31.624691	46	EXECUTED	9:b855e9b0a406b34fa323235a0cf4f640	customChange		\N	4.8.0	\N	\N	8425129015
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-11-14 11:25:31.626302	47	MARK_RAN	9:51abbacd7b416c50c4421a8cabf7927e	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	4.8.0	\N	\N	8425129015
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-11-14 11:25:31.707561	48	EXECUTED	9:bdc99e567b3398bac83263d375aad143	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	4.8.0	\N	\N	8425129015
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2022-11-14 11:25:31.781536	50	EXECUTED	9:cfdd8736332ccdd72c5256ccb42335db	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	4.8.0	\N	\N	8425129015
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2022-11-14 11:25:31.841939	51	EXECUTED	9:7c84de3d9bd84d7f077607c1a4dcb714	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	4.8.0	\N	\N	8425129015
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2022-11-14 11:25:31.845011	52	EXECUTED	9:5a6bb36cbefb6a9d6928452c0852af2d	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	8425129015
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2022-11-14 11:25:31.848047	53	EXECUTED	9:8f23e334dbc59f82e0a328373ca6ced0	update tableName=REALM		\N	4.8.0	\N	\N	8425129015
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2022-11-14 11:25:31.852208	54	EXECUTED	9:9156214268f09d970cdf0e1564d866af	update tableName=CLIENT		\N	4.8.0	\N	\N	8425129015
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2022-11-14 11:25:31.878576	56	EXECUTED	9:229a041fb72d5beac76bb94a5fa709de	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	4.8.0	\N	\N	8425129015
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2022-11-14 11:25:31.915836	57	EXECUTED	9:079899dade9c1e683f26b2aa9ca6ff04	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	4.8.0	\N	\N	8425129015
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2022-11-14 11:25:32.094856	58	EXECUTED	9:139b79bcbbfe903bb1c2d2a4dbf001d9	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	4.8.0	\N	\N	8425129015
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2022-11-14 11:25:32.141534	59	EXECUTED	9:b55738ad889860c625ba2bf483495a04	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	4.8.0	\N	\N	8425129015
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2022-11-14 11:25:32.149313	60	EXECUTED	9:e0057eac39aa8fc8e09ac6cfa4ae15fe	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	4.8.0	\N	\N	8425129015
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2022-11-14 11:25:32.158918	61	EXECUTED	9:42a33806f3a0443fe0e7feeec821326c	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	4.8.0	\N	\N	8425129015
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2022-11-14 11:25:32.16484	62	EXECUTED	9:9968206fca46eecc1f51db9c024bfe56	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	4.8.0	\N	\N	8425129015
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2022-11-14 11:25:32.167125	63	EXECUTED	9:92143a6daea0a3f3b8f598c97ce55c3d	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	4.8.0	\N	\N	8425129015
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2022-11-14 11:25:32.170701	64	EXECUTED	9:82bab26a27195d889fb0429003b18f40	update tableName=REQUIRED_ACTION_PROVIDER		\N	4.8.0	\N	\N	8425129015
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2022-11-14 11:25:32.173258	65	EXECUTED	9:e590c88ddc0b38b0ae4249bbfcb5abc3	update tableName=RESOURCE_SERVER_RESOURCE		\N	4.8.0	\N	\N	8425129015
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2022-11-14 11:25:32.198068	66	EXECUTED	9:5c1f475536118dbdc38d5d7977950cc0	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	4.8.0	\N	\N	8425129015
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2022-11-14 11:25:32.205732	67	EXECUTED	9:e7c9f5f9c4d67ccbbcc215440c718a17	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	4.8.0	\N	\N	8425129015
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2022-11-14 11:25:32.209132	68	EXECUTED	9:88e0bfdda924690d6f4e430c53447dd5	addColumn tableName=REALM		\N	4.8.0	\N	\N	8425129015
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2022-11-14 11:25:32.221949	69	EXECUTED	9:f53177f137e1c46b6a88c59ec1cb5218	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	4.8.0	\N	\N	8425129015
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2022-11-14 11:25:32.227516	70	EXECUTED	9:a74d33da4dc42a37ec27121580d1459f	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	4.8.0	\N	\N	8425129015
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2022-11-14 11:25:32.231676	71	EXECUTED	9:fd4ade7b90c3b67fae0bfcfcb42dfb5f	addColumn tableName=RESOURCE_SERVER		\N	4.8.0	\N	\N	8425129015
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-11-14 11:25:32.236047	72	EXECUTED	9:aa072ad090bbba210d8f18781b8cebf4	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	4.8.0	\N	\N	8425129015
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-11-14 11:25:32.244815	73	EXECUTED	9:1ae6be29bab7c2aa376f6983b932be37	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.8.0	\N	\N	8425129015
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-11-14 11:25:32.246079	74	MARK_RAN	9:14706f286953fc9a25286dbd8fb30d97	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.8.0	\N	\N	8425129015
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-11-14 11:25:32.283194	75	EXECUTED	9:2b9cc12779be32c5b40e2e67711a218b	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	4.8.0	\N	\N	8425129015
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-11-14 11:25:32.291856	76	EXECUTED	9:91fa186ce7a5af127a2d7a91ee083cc5	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.8.0	\N	\N	8425129015
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2022-11-14 11:25:32.29447	77	EXECUTED	9:6335e5c94e83a2639ccd68dd24e2e5ad	addColumn tableName=CLIENT		\N	4.8.0	\N	\N	8425129015
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2022-11-14 11:25:32.295744	78	MARK_RAN	9:6bdb5658951e028bfe16fa0a8228b530	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	4.8.0	\N	\N	8425129015
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2022-11-14 11:25:32.324229	79	EXECUTED	9:d5bc15a64117ccad481ce8792d4c608f	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	4.8.0	\N	\N	8425129015
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2022-11-14 11:25:32.325773	80	MARK_RAN	9:077cba51999515f4d3e7ad5619ab592c	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	4.8.0	\N	\N	8425129015
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-11-14 11:25:32.333893	81	EXECUTED	9:be969f08a163bf47c6b9e9ead8ac2afb	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	4.8.0	\N	\N	8425129015
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-11-14 11:25:32.335319	82	MARK_RAN	9:6d3bb4408ba5a72f39bd8a0b301ec6e3	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	8425129015
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-11-14 11:25:32.340895	83	EXECUTED	9:966bda61e46bebf3cc39518fbed52fa7	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	8425129015
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-11-14 11:25:32.342454	84	MARK_RAN	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	8425129015
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-11-14 11:25:32.348735	85	EXECUTED	9:7d93d602352a30c0c317e6a609b56599	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	4.8.0	\N	\N	8425129015
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2022-11-14 11:25:32.352112	86	EXECUTED	9:71c5969e6cdd8d7b6f47cebc86d37627	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	4.8.0	\N	\N	8425129015
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2022-11-14 11:25:32.357498	87	EXECUTED	9:a9ba7d47f065f041b7da856a81762021	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	4.8.0	\N	\N	8425129015
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2022-11-14 11:25:32.374363	88	EXECUTED	9:fffabce2bc01e1a8f5110d5278500065	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	4.8.0	\N	\N	8425129015
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-11-14 11:25:32.381193	89	EXECUTED	9:fa8a5b5445e3857f4b010bafb5009957	addColumn tableName=REALM; customChange		\N	4.8.0	\N	\N	8425129015
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-11-14 11:25:32.403773	90	EXECUTED	9:67ac3241df9a8582d591c5ed87125f39	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	4.8.0	\N	\N	8425129015
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-11-14 11:25:32.410702	91	EXECUTED	9:ad1194d66c937e3ffc82386c050ba089	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	8425129015
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-11-14 11:25:32.416512	92	EXECUTED	9:d9be619d94af5a2f5d07b9f003543b91	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	4.8.0	\N	\N	8425129015
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-11-14 11:25:32.417904	93	MARK_RAN	9:544d201116a0fcc5a5da0925fbbc3bde	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	4.8.0	\N	\N	8425129015
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-11-14 11:25:32.431718	94	EXECUTED	9:43c0c1055b6761b4b3e89de76d612ccf	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	4.8.0	\N	\N	8425129015
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-11-14 11:25:32.433957	95	MARK_RAN	9:8bd711fd0330f4fe980494ca43ab1139	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	4.8.0	\N	\N	8425129015
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-11-14 11:25:32.444623	96	EXECUTED	9:e07d2bc0970c348bb06fb63b1f82ddbf	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	4.8.0	\N	\N	8425129015
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-11-14 11:25:32.461139	97	EXECUTED	9:24fb8611e97f29989bea412aa38d12b7	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	8425129015
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-11-14 11:25:32.462629	98	MARK_RAN	9:259f89014ce2506ee84740cbf7163aa7	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	8425129015
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-11-14 11:25:32.481429	99	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	8425129015
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-11-14 11:25:32.488648	100	EXECUTED	9:60ca84a0f8c94ec8c3504a5a3bc88ee8	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	8425129015
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-11-14 11:25:32.490206	101	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	8425129015
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-11-14 11:25:32.49682	102	EXECUTED	9:0b305d8d1277f3a89a0a53a659ad274c	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	4.8.0	\N	\N	8425129015
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-11-14 11:25:32.500688	103	EXECUTED	9:2c374ad2cdfe20e2905a84c8fac48460	customChange		\N	4.8.0	\N	\N	8425129015
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2022-11-14 11:25:32.507601	104	EXECUTED	9:47a760639ac597360a8219f5b768b4de	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	4.8.0	\N	\N	8425129015
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2022-11-14 11:25:32.52145	105	EXECUTED	9:a6272f0576727dd8cad2522335f5d99e	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	4.8.0	\N	\N	8425129015
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2022-11-14 11:25:32.528337	106	EXECUTED	9:015479dbd691d9cc8669282f4828c41d	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	4.8.0	\N	\N	8425129015
19.0.0-10135	keycloak	META-INF/jpa-changelog-19.0.0.xml	2022-11-14 11:25:32.53196	107	EXECUTED	9:9518e495fdd22f78ad6425cc30630221	customChange		\N	4.8.0	\N	\N	8425129015
20.0.0-12964-supported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2022-11-14 11:25:32.539386	108	EXECUTED	9:e5f243877199fd96bcc842f27a1656ac	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.8.0	\N	\N	8425129015
20.0.0-12964-unsupported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2022-11-14 11:25:32.540903	109	MARK_RAN	9:1a6fcaa85e20bdeae0a9ce49b41946a5	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.8.0	\N	\N	8425129015
client-attributes-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-20.0.0.xml	2022-11-14 11:25:32.55223	110	EXECUTED	9:3f332e13e90739ed0c35b0b25b7822ca	addColumn tableName=CLIENT_ATTRIBUTES; update tableName=CLIENT_ATTRIBUTES; dropColumn columnName=VALUE, tableName=CLIENT_ATTRIBUTES; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	8425129015
21.0.2-17277	keycloak	META-INF/jpa-changelog-21.0.2.xml	2024-06-07 17:17:16.466462	111	EXECUTED	9:7ee1f7a3fb8f5588f171fb9a6ab623c0	customChange		\N	4.25.1	\N	\N	7780636122
21.1.0-19404	keycloak	META-INF/jpa-changelog-21.1.0.xml	2024-06-07 17:17:16.48875	112	EXECUTED	9:3d7e830b52f33676b9d64f7f2b2ea634	modifyDataType columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=LOGIC, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=POLICY_ENFORCE_MODE, tableName=RESOURCE_SERVER		\N	4.25.1	\N	\N	7780636122
21.1.0-19404-2	keycloak	META-INF/jpa-changelog-21.1.0.xml	2024-06-07 17:17:16.491642	113	MARK_RAN	9:627d032e3ef2c06c0e1f73d2ae25c26c	addColumn tableName=RESOURCE_SERVER_POLICY; update tableName=RESOURCE_SERVER_POLICY; dropColumn columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; renameColumn newColumnName=DECISION_STRATEGY, oldColumnName=DECISION_STRATEGY_NEW, tabl...		\N	4.25.1	\N	\N	7780636122
22.0.0-17484-updated	keycloak	META-INF/jpa-changelog-22.0.0.xml	2024-06-07 17:17:16.506929	114	EXECUTED	9:90af0bfd30cafc17b9f4d6eccd92b8b3	customChange		\N	4.25.1	\N	\N	7780636122
22.0.5-24031	keycloak	META-INF/jpa-changelog-22.0.0.xml	2024-06-07 17:17:16.508532	115	MARK_RAN	9:a60d2d7b315ec2d3eba9e2f145f9df28	customChange		\N	4.25.1	\N	\N	7780636122
23.0.0-12062	keycloak	META-INF/jpa-changelog-23.0.0.xml	2024-06-07 17:17:16.518691	116	EXECUTED	9:2168fbe728fec46ae9baf15bf80927b8	addColumn tableName=COMPONENT_CONFIG; update tableName=COMPONENT_CONFIG; dropColumn columnName=VALUE, tableName=COMPONENT_CONFIG; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=COMPONENT_CONFIG		\N	4.25.1	\N	\N	7780636122
23.0.0-17258	keycloak	META-INF/jpa-changelog-23.0.0.xml	2024-06-07 17:17:16.523071	117	EXECUTED	9:36506d679a83bbfda85a27ea1864dca8	addColumn tableName=EVENT_ENTITY		\N	4.25.1	\N	\N	7780636122
24.0.0-9758	keycloak	META-INF/jpa-changelog-24.0.0.xml	2024-06-07 17:17:16.54496	118	EXECUTED	9:502c557a5189f600f0f445a9b49ebbce	addColumn tableName=USER_ATTRIBUTE; addColumn tableName=FED_USER_ATTRIBUTE; createIndex indexName=USER_ATTR_LONG_VALUES, tableName=USER_ATTRIBUTE; createIndex indexName=FED_USER_ATTR_LONG_VALUES, tableName=FED_USER_ATTRIBUTE; createIndex indexName...		\N	4.25.1	\N	\N	7780636122
24.0.0-9758-2	keycloak	META-INF/jpa-changelog-24.0.0.xml	2024-06-07 17:17:16.55147	119	EXECUTED	9:bf0fdee10afdf597a987adbf291db7b2	customChange		\N	4.25.1	\N	\N	7780636122
24.0.0-26618-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.0.xml	2024-06-07 17:17:16.558276	120	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	7780636122
24.0.0-26618-reindex	keycloak	META-INF/jpa-changelog-24.0.0.xml	2024-06-07 17:17:16.564914	121	EXECUTED	9:08707c0f0db1cef6b352db03a60edc7f	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	7780636122
24.0.2-27228	keycloak	META-INF/jpa-changelog-24.0.2.xml	2024-06-07 17:17:16.576032	122	EXECUTED	9:eaee11f6b8aa25d2cc6a84fb86fc6238	customChange		\N	4.25.1	\N	\N	7780636122
24.0.2-27967-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.2.xml	2024-06-07 17:17:16.579025	123	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	7780636122
24.0.2-27967-reindex	keycloak	META-INF/jpa-changelog-24.0.2.xml	2024-06-07 17:17:16.58288	124	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	7780636122
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
1001	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
7aa9c96c-04c3-424e-8bf5-94873e7e3275	23c348b7-7c78-4ded-8124-6c9e2a5d5d94	f
7aa9c96c-04c3-424e-8bf5-94873e7e3275	604b586b-a4a0-4798-936d-acb761f39acf	t
7aa9c96c-04c3-424e-8bf5-94873e7e3275	fd497d05-e3f5-4932-b76d-1c0a76c651f3	t
7aa9c96c-04c3-424e-8bf5-94873e7e3275	3cc9757b-d962-4f88-9da1-d7f8274a4365	t
7aa9c96c-04c3-424e-8bf5-94873e7e3275	1d720f36-9829-4030-aa69-aa06b2782285	f
7aa9c96c-04c3-424e-8bf5-94873e7e3275	a3728da9-a45a-4937-9f81-dfac2a95f2bc	f
7aa9c96c-04c3-424e-8bf5-94873e7e3275	943bc85e-622f-4d58-af01-f722a64a69a2	t
7aa9c96c-04c3-424e-8bf5-94873e7e3275	90e717d8-7122-49d8-8fdf-4cb9bbc54c0e	t
7aa9c96c-04c3-424e-8bf5-94873e7e3275	58c8c8ff-d76a-43b2-bf22-352ca81e77b1	f
7aa9c96c-04c3-424e-8bf5-94873e7e3275	bcafe427-ccd8-4b4b-a6a1-3d26ce88bb77	t
68507cda-c551-4ae5-8e9b-474fc4f60060	cf45d72f-4857-4106-953e-487ed89f4b65	t
68507cda-c551-4ae5-8e9b-474fc4f60060	56f50926-caf1-438e-aa91-299a94aad2f6	t
68507cda-c551-4ae5-8e9b-474fc4f60060	c6b2bc7d-050e-423a-b6e1-d85206e66ab6	t
68507cda-c551-4ae5-8e9b-474fc4f60060	05aeab96-1872-4724-b68a-92ad0ed90189	t
68507cda-c551-4ae5-8e9b-474fc4f60060	789f9eaa-ba68-4f07-ae85-0e7d70235c9c	t
68507cda-c551-4ae5-8e9b-474fc4f60060	b44476bf-b17b-4571-84d7-1cd18161766e	t
68507cda-c551-4ae5-8e9b-474fc4f60060	15769899-23b3-47b4-b8d1-710c66d7acbe	f
68507cda-c551-4ae5-8e9b-474fc4f60060	1956f6f1-1bea-4afa-998b-ed36c4de5640	f
68507cda-c551-4ae5-8e9b-474fc4f60060	c5072f00-890e-41a3-8fec-3f2276ee765a	f
68507cda-c551-4ae5-8e9b-474fc4f60060	395eea87-4dde-4f6c-9c61-9da6fb8a9f67	f
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id, details_json_long_value) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value, long_value_hash, long_value_hash_lower_case, long_value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only) FROM stdin;
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.keycloak_group (id, name, parent_group, realm_id) FROM stdin;
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
137b4a16-e5b8-4ac6-9ca3-0121e1f66f4e	7aa9c96c-04c3-424e-8bf5-94873e7e3275	f	${role_default-roles}	default-roles-master	7aa9c96c-04c3-424e-8bf5-94873e7e3275	\N	\N
469c5ad7-a51f-4492-9f64-d17b7ae6953e	7aa9c96c-04c3-424e-8bf5-94873e7e3275	f	${role_create-realm}	create-realm	7aa9c96c-04c3-424e-8bf5-94873e7e3275	\N	\N
742fe314-bb0a-4e40-acea-9a4ab20bf605	7aa9c96c-04c3-424e-8bf5-94873e7e3275	f	${role_admin}	admin	7aa9c96c-04c3-424e-8bf5-94873e7e3275	\N	\N
0d5c9c1b-5ca4-4059-9a00-6e54f3ce0084	75a512b0-fb5a-409d-aa9c-49ef04cdc299	t	${role_create-client}	create-client	7aa9c96c-04c3-424e-8bf5-94873e7e3275	75a512b0-fb5a-409d-aa9c-49ef04cdc299	\N
f3fd4706-f990-4831-b2cc-428f5ffcf492	75a512b0-fb5a-409d-aa9c-49ef04cdc299	t	${role_view-realm}	view-realm	7aa9c96c-04c3-424e-8bf5-94873e7e3275	75a512b0-fb5a-409d-aa9c-49ef04cdc299	\N
5d5955c6-2aab-4aaf-bc7c-5b2cc6d5bc10	75a512b0-fb5a-409d-aa9c-49ef04cdc299	t	${role_view-users}	view-users	7aa9c96c-04c3-424e-8bf5-94873e7e3275	75a512b0-fb5a-409d-aa9c-49ef04cdc299	\N
f3f6f88b-fd04-498c-ae6b-c658f7a56755	75a512b0-fb5a-409d-aa9c-49ef04cdc299	t	${role_view-clients}	view-clients	7aa9c96c-04c3-424e-8bf5-94873e7e3275	75a512b0-fb5a-409d-aa9c-49ef04cdc299	\N
8ee32bee-9aca-4f75-b878-8fa7b6576571	75a512b0-fb5a-409d-aa9c-49ef04cdc299	t	${role_view-events}	view-events	7aa9c96c-04c3-424e-8bf5-94873e7e3275	75a512b0-fb5a-409d-aa9c-49ef04cdc299	\N
14945a4c-5363-48dc-b539-fe301dc02621	75a512b0-fb5a-409d-aa9c-49ef04cdc299	t	${role_view-identity-providers}	view-identity-providers	7aa9c96c-04c3-424e-8bf5-94873e7e3275	75a512b0-fb5a-409d-aa9c-49ef04cdc299	\N
b2d01646-edb9-40c6-9a98-5c27a408e0b6	75a512b0-fb5a-409d-aa9c-49ef04cdc299	t	${role_view-authorization}	view-authorization	7aa9c96c-04c3-424e-8bf5-94873e7e3275	75a512b0-fb5a-409d-aa9c-49ef04cdc299	\N
4d9be543-1691-4bf0-8c5a-8bbba0d413df	75a512b0-fb5a-409d-aa9c-49ef04cdc299	t	${role_manage-realm}	manage-realm	7aa9c96c-04c3-424e-8bf5-94873e7e3275	75a512b0-fb5a-409d-aa9c-49ef04cdc299	\N
f6828e21-ab2a-4673-9a98-905fc674437f	75a512b0-fb5a-409d-aa9c-49ef04cdc299	t	${role_manage-users}	manage-users	7aa9c96c-04c3-424e-8bf5-94873e7e3275	75a512b0-fb5a-409d-aa9c-49ef04cdc299	\N
366e1fc0-db07-4bc0-a9bc-4ac401d62e23	75a512b0-fb5a-409d-aa9c-49ef04cdc299	t	${role_manage-clients}	manage-clients	7aa9c96c-04c3-424e-8bf5-94873e7e3275	75a512b0-fb5a-409d-aa9c-49ef04cdc299	\N
003c1039-9b8c-44c1-af3a-abd17b8803e0	75a512b0-fb5a-409d-aa9c-49ef04cdc299	t	${role_manage-events}	manage-events	7aa9c96c-04c3-424e-8bf5-94873e7e3275	75a512b0-fb5a-409d-aa9c-49ef04cdc299	\N
fd8ecca4-8e6e-4ffa-8a2a-524aea724c10	75a512b0-fb5a-409d-aa9c-49ef04cdc299	t	${role_manage-identity-providers}	manage-identity-providers	7aa9c96c-04c3-424e-8bf5-94873e7e3275	75a512b0-fb5a-409d-aa9c-49ef04cdc299	\N
bfe597b8-3faf-457c-bdfe-5c15d19fe6b2	75a512b0-fb5a-409d-aa9c-49ef04cdc299	t	${role_manage-authorization}	manage-authorization	7aa9c96c-04c3-424e-8bf5-94873e7e3275	75a512b0-fb5a-409d-aa9c-49ef04cdc299	\N
ebf19b3d-5f55-4f0d-b20c-a4a63546304e	75a512b0-fb5a-409d-aa9c-49ef04cdc299	t	${role_query-users}	query-users	7aa9c96c-04c3-424e-8bf5-94873e7e3275	75a512b0-fb5a-409d-aa9c-49ef04cdc299	\N
abfac688-c89e-4c02-ac0b-d6570590fa73	75a512b0-fb5a-409d-aa9c-49ef04cdc299	t	${role_query-clients}	query-clients	7aa9c96c-04c3-424e-8bf5-94873e7e3275	75a512b0-fb5a-409d-aa9c-49ef04cdc299	\N
596feaa4-a1bb-4352-b74b-f07f7129b9ec	75a512b0-fb5a-409d-aa9c-49ef04cdc299	t	${role_query-realms}	query-realms	7aa9c96c-04c3-424e-8bf5-94873e7e3275	75a512b0-fb5a-409d-aa9c-49ef04cdc299	\N
f4c1af3b-38a2-437a-8225-e71d722dc0ea	75a512b0-fb5a-409d-aa9c-49ef04cdc299	t	${role_query-groups}	query-groups	7aa9c96c-04c3-424e-8bf5-94873e7e3275	75a512b0-fb5a-409d-aa9c-49ef04cdc299	\N
92caaa7c-167f-4e22-acb1-5657a5731add	aa841261-1c2f-4788-a9e7-74fac384acd8	t	${role_view-profile}	view-profile	7aa9c96c-04c3-424e-8bf5-94873e7e3275	aa841261-1c2f-4788-a9e7-74fac384acd8	\N
78d73956-992b-423b-8955-bc8b1cc11b5e	aa841261-1c2f-4788-a9e7-74fac384acd8	t	${role_manage-account}	manage-account	7aa9c96c-04c3-424e-8bf5-94873e7e3275	aa841261-1c2f-4788-a9e7-74fac384acd8	\N
0becb182-81a3-4676-870f-608a56cc5cb7	aa841261-1c2f-4788-a9e7-74fac384acd8	t	${role_manage-account-links}	manage-account-links	7aa9c96c-04c3-424e-8bf5-94873e7e3275	aa841261-1c2f-4788-a9e7-74fac384acd8	\N
a3e51f51-486e-4712-a002-c51d6fa039fa	aa841261-1c2f-4788-a9e7-74fac384acd8	t	${role_view-applications}	view-applications	7aa9c96c-04c3-424e-8bf5-94873e7e3275	aa841261-1c2f-4788-a9e7-74fac384acd8	\N
24dc1534-6cc0-412c-964b-3eedc980623a	aa841261-1c2f-4788-a9e7-74fac384acd8	t	${role_view-consent}	view-consent	7aa9c96c-04c3-424e-8bf5-94873e7e3275	aa841261-1c2f-4788-a9e7-74fac384acd8	\N
90f44e44-3321-4d07-9dd0-fe13c764d389	aa841261-1c2f-4788-a9e7-74fac384acd8	t	${role_manage-consent}	manage-consent	7aa9c96c-04c3-424e-8bf5-94873e7e3275	aa841261-1c2f-4788-a9e7-74fac384acd8	\N
8670c3d2-03ac-4f16-ac7e-014021575fa9	aa841261-1c2f-4788-a9e7-74fac384acd8	t	${role_view-groups}	view-groups	7aa9c96c-04c3-424e-8bf5-94873e7e3275	aa841261-1c2f-4788-a9e7-74fac384acd8	\N
3fc9e2f4-6c64-483a-94ed-094394cc0508	aa841261-1c2f-4788-a9e7-74fac384acd8	t	${role_delete-account}	delete-account	7aa9c96c-04c3-424e-8bf5-94873e7e3275	aa841261-1c2f-4788-a9e7-74fac384acd8	\N
20a14c2d-c8af-4371-8768-f2c5b9825929	349b16da-d67b-486b-9bac-1f891b9e4ec9	t	${role_read-token}	read-token	7aa9c96c-04c3-424e-8bf5-94873e7e3275	349b16da-d67b-486b-9bac-1f891b9e4ec9	\N
84f0c80e-199d-4320-9e11-6b8dc939d773	75a512b0-fb5a-409d-aa9c-49ef04cdc299	t	${role_impersonation}	impersonation	7aa9c96c-04c3-424e-8bf5-94873e7e3275	75a512b0-fb5a-409d-aa9c-49ef04cdc299	\N
839a4ab2-997d-42e3-8a08-9a06a8a393e4	7aa9c96c-04c3-424e-8bf5-94873e7e3275	f	${role_offline-access}	offline_access	7aa9c96c-04c3-424e-8bf5-94873e7e3275	\N	\N
039f9dd6-880c-4596-9e09-b7a42d8acb6a	7aa9c96c-04c3-424e-8bf5-94873e7e3275	f	${role_uma_authorization}	uma_authorization	7aa9c96c-04c3-424e-8bf5-94873e7e3275	\N	\N
2d4a63df-b516-4663-8eb3-2bb54255b970	68507cda-c551-4ae5-8e9b-474fc4f60060	f	${role_default-roles}	default-roles-example	68507cda-c551-4ae5-8e9b-474fc4f60060	\N	\N
ee8056eb-d725-424b-abc5-b0eea6e9a609	1499cf0a-a797-46f4-ae55-f7a762ee295a	t	${role_create-client}	create-client	7aa9c96c-04c3-424e-8bf5-94873e7e3275	1499cf0a-a797-46f4-ae55-f7a762ee295a	\N
1f5084bd-0d07-4c35-b287-9faed54987b2	1499cf0a-a797-46f4-ae55-f7a762ee295a	t	${role_view-realm}	view-realm	7aa9c96c-04c3-424e-8bf5-94873e7e3275	1499cf0a-a797-46f4-ae55-f7a762ee295a	\N
65bfcedf-0f48-4bf7-919d-c5af4b2eb532	1499cf0a-a797-46f4-ae55-f7a762ee295a	t	${role_view-users}	view-users	7aa9c96c-04c3-424e-8bf5-94873e7e3275	1499cf0a-a797-46f4-ae55-f7a762ee295a	\N
ee26c12b-e8d9-4a2b-a43e-10e64ddf9476	1499cf0a-a797-46f4-ae55-f7a762ee295a	t	${role_view-clients}	view-clients	7aa9c96c-04c3-424e-8bf5-94873e7e3275	1499cf0a-a797-46f4-ae55-f7a762ee295a	\N
dccc011c-a5a3-4e29-a87a-7d83566e59b8	1499cf0a-a797-46f4-ae55-f7a762ee295a	t	${role_view-events}	view-events	7aa9c96c-04c3-424e-8bf5-94873e7e3275	1499cf0a-a797-46f4-ae55-f7a762ee295a	\N
537004e9-5509-470e-9cc8-28f4d7f841b9	1499cf0a-a797-46f4-ae55-f7a762ee295a	t	${role_view-identity-providers}	view-identity-providers	7aa9c96c-04c3-424e-8bf5-94873e7e3275	1499cf0a-a797-46f4-ae55-f7a762ee295a	\N
4a3b6893-2b09-4840-8896-4dcda2bb5f72	1499cf0a-a797-46f4-ae55-f7a762ee295a	t	${role_view-authorization}	view-authorization	7aa9c96c-04c3-424e-8bf5-94873e7e3275	1499cf0a-a797-46f4-ae55-f7a762ee295a	\N
2b0e54e9-ae19-4af6-9616-fcd765b3ad23	1499cf0a-a797-46f4-ae55-f7a762ee295a	t	${role_manage-realm}	manage-realm	7aa9c96c-04c3-424e-8bf5-94873e7e3275	1499cf0a-a797-46f4-ae55-f7a762ee295a	\N
822b79ed-05a3-4c63-8bfb-ff6bf40e45c3	1499cf0a-a797-46f4-ae55-f7a762ee295a	t	${role_manage-users}	manage-users	7aa9c96c-04c3-424e-8bf5-94873e7e3275	1499cf0a-a797-46f4-ae55-f7a762ee295a	\N
5f11a15b-7e09-4a9f-8d98-f4d6e9f28576	1499cf0a-a797-46f4-ae55-f7a762ee295a	t	${role_manage-clients}	manage-clients	7aa9c96c-04c3-424e-8bf5-94873e7e3275	1499cf0a-a797-46f4-ae55-f7a762ee295a	\N
1d4c7081-f6a5-46e5-a338-754138a917fc	1499cf0a-a797-46f4-ae55-f7a762ee295a	t	${role_manage-events}	manage-events	7aa9c96c-04c3-424e-8bf5-94873e7e3275	1499cf0a-a797-46f4-ae55-f7a762ee295a	\N
e3afbad0-dc35-4e16-97f9-37d276c68906	1499cf0a-a797-46f4-ae55-f7a762ee295a	t	${role_manage-identity-providers}	manage-identity-providers	7aa9c96c-04c3-424e-8bf5-94873e7e3275	1499cf0a-a797-46f4-ae55-f7a762ee295a	\N
b9d1e31e-5ddb-4436-938b-9f1c4d530804	1499cf0a-a797-46f4-ae55-f7a762ee295a	t	${role_manage-authorization}	manage-authorization	7aa9c96c-04c3-424e-8bf5-94873e7e3275	1499cf0a-a797-46f4-ae55-f7a762ee295a	\N
ff85a43f-2994-48a1-9289-e016fdd036f2	1499cf0a-a797-46f4-ae55-f7a762ee295a	t	${role_query-users}	query-users	7aa9c96c-04c3-424e-8bf5-94873e7e3275	1499cf0a-a797-46f4-ae55-f7a762ee295a	\N
526a9e15-dbd3-40aa-ad65-6d6441e66bbf	1499cf0a-a797-46f4-ae55-f7a762ee295a	t	${role_query-clients}	query-clients	7aa9c96c-04c3-424e-8bf5-94873e7e3275	1499cf0a-a797-46f4-ae55-f7a762ee295a	\N
10044ebb-0d89-495f-97d0-bc4efcf7bf73	1499cf0a-a797-46f4-ae55-f7a762ee295a	t	${role_query-realms}	query-realms	7aa9c96c-04c3-424e-8bf5-94873e7e3275	1499cf0a-a797-46f4-ae55-f7a762ee295a	\N
67d973d1-3695-408e-ad5b-bbf5551a43c0	1499cf0a-a797-46f4-ae55-f7a762ee295a	t	${role_query-groups}	query-groups	7aa9c96c-04c3-424e-8bf5-94873e7e3275	1499cf0a-a797-46f4-ae55-f7a762ee295a	\N
a0810f98-b38d-44c0-a28a-9d3ed868c52d	68507cda-c551-4ae5-8e9b-474fc4f60060	f	${role_uma_authorization}	uma_authorization	68507cda-c551-4ae5-8e9b-474fc4f60060	\N	\N
ed2d2483-278c-48da-84d1-636df5351394	68507cda-c551-4ae5-8e9b-474fc4f60060	f	${role_offline-access}	offline_access	68507cda-c551-4ae5-8e9b-474fc4f60060	\N	\N
320a3eaf-55a0-4979-962b-437b72ee5965	68507cda-c551-4ae5-8e9b-474fc4f60060	f		example	68507cda-c551-4ae5-8e9b-474fc4f60060	\N	\N
48ac17ff-1e6c-44d4-b77b-2444b74da7d9	5461f065-8e95-4336-a83d-6c71669feb41	t	${role_realm-admin}	realm-admin	68507cda-c551-4ae5-8e9b-474fc4f60060	5461f065-8e95-4336-a83d-6c71669feb41	\N
23bb30ca-527e-44b9-8d7f-97be52f9eefd	5461f065-8e95-4336-a83d-6c71669feb41	t	${role_impersonation}	impersonation	68507cda-c551-4ae5-8e9b-474fc4f60060	5461f065-8e95-4336-a83d-6c71669feb41	\N
c967e37c-9868-40df-80ef-b2759f98ce99	5461f065-8e95-4336-a83d-6c71669feb41	t	${role_manage-events}	manage-events	68507cda-c551-4ae5-8e9b-474fc4f60060	5461f065-8e95-4336-a83d-6c71669feb41	\N
c6d618c2-0218-4277-ac7a-184f9a81d91d	5461f065-8e95-4336-a83d-6c71669feb41	t	${role_manage-realm}	manage-realm	68507cda-c551-4ae5-8e9b-474fc4f60060	5461f065-8e95-4336-a83d-6c71669feb41	\N
b0d2ea45-0be6-4ece-835b-5f4cbfff8afb	5461f065-8e95-4336-a83d-6c71669feb41	t	${role_manage-clients}	manage-clients	68507cda-c551-4ae5-8e9b-474fc4f60060	5461f065-8e95-4336-a83d-6c71669feb41	\N
b4f3e6be-6a29-4f4e-a994-c66d190c7040	5461f065-8e95-4336-a83d-6c71669feb41	t	${role_view-clients}	view-clients	68507cda-c551-4ae5-8e9b-474fc4f60060	5461f065-8e95-4336-a83d-6c71669feb41	\N
f89343c0-2fcd-42d3-9692-f33d6b335342	5461f065-8e95-4336-a83d-6c71669feb41	t	${role_view-authorization}	view-authorization	68507cda-c551-4ae5-8e9b-474fc4f60060	5461f065-8e95-4336-a83d-6c71669feb41	\N
39a130ef-0898-4859-903c-e1251cbf74e6	5461f065-8e95-4336-a83d-6c71669feb41	t	${role_view-events}	view-events	68507cda-c551-4ae5-8e9b-474fc4f60060	5461f065-8e95-4336-a83d-6c71669feb41	\N
2dc77f93-9086-4191-b0c4-4b629b3a175c	5461f065-8e95-4336-a83d-6c71669feb41	t	${role_view-identity-providers}	view-identity-providers	68507cda-c551-4ae5-8e9b-474fc4f60060	5461f065-8e95-4336-a83d-6c71669feb41	\N
5818b0d5-07bc-4aab-9d81-6b6d25715251	5461f065-8e95-4336-a83d-6c71669feb41	t	${role_view-realm}	view-realm	68507cda-c551-4ae5-8e9b-474fc4f60060	5461f065-8e95-4336-a83d-6c71669feb41	\N
2f4e3173-9aa6-4ea2-94eb-91c9796a2065	5461f065-8e95-4336-a83d-6c71669feb41	t	${role_query-realms}	query-realms	68507cda-c551-4ae5-8e9b-474fc4f60060	5461f065-8e95-4336-a83d-6c71669feb41	\N
e7ac2ec4-38b8-4241-8d4b-3ad65e29991a	5461f065-8e95-4336-a83d-6c71669feb41	t	${role_manage-users}	manage-users	68507cda-c551-4ae5-8e9b-474fc4f60060	5461f065-8e95-4336-a83d-6c71669feb41	\N
af1675b5-beec-4448-a09d-53524bcef6bf	5461f065-8e95-4336-a83d-6c71669feb41	t	${role_query-clients}	query-clients	68507cda-c551-4ae5-8e9b-474fc4f60060	5461f065-8e95-4336-a83d-6c71669feb41	\N
a055025c-b805-446f-9e31-1836e3afc34e	5461f065-8e95-4336-a83d-6c71669feb41	t	${role_create-client}	create-client	68507cda-c551-4ae5-8e9b-474fc4f60060	5461f065-8e95-4336-a83d-6c71669feb41	\N
ba11bfa0-990d-4516-a0c7-d4fcc9e8e74b	5461f065-8e95-4336-a83d-6c71669feb41	t	${role_query-users}	query-users	68507cda-c551-4ae5-8e9b-474fc4f60060	5461f065-8e95-4336-a83d-6c71669feb41	\N
9fbaa847-f9e6-49ff-9ee5-e605eac8cfd2	5461f065-8e95-4336-a83d-6c71669feb41	t	${role_manage-identity-providers}	manage-identity-providers	68507cda-c551-4ae5-8e9b-474fc4f60060	5461f065-8e95-4336-a83d-6c71669feb41	\N
05070aea-a2af-4faa-bfed-2cd497bcdeca	5461f065-8e95-4336-a83d-6c71669feb41	t	${role_manage-authorization}	manage-authorization	68507cda-c551-4ae5-8e9b-474fc4f60060	5461f065-8e95-4336-a83d-6c71669feb41	\N
44a267e0-bdb6-488c-a9a3-c6ae9af8b2d9	5461f065-8e95-4336-a83d-6c71669feb41	t	${role_query-groups}	query-groups	68507cda-c551-4ae5-8e9b-474fc4f60060	5461f065-8e95-4336-a83d-6c71669feb41	\N
429cc12d-78fc-45b9-a420-1a8ee239ade8	5461f065-8e95-4336-a83d-6c71669feb41	t	${role_view-users}	view-users	68507cda-c551-4ae5-8e9b-474fc4f60060	5461f065-8e95-4336-a83d-6c71669feb41	\N
75608392-1cba-4c9e-a902-e1ab7b12420e	9d21a393-f724-4aad-adf5-a32b3e54cf06	t	${role_read-token}	read-token	68507cda-c551-4ae5-8e9b-474fc4f60060	9d21a393-f724-4aad-adf5-a32b3e54cf06	\N
dcf04124-d692-4b4e-84c5-05251941c0f4	2e36e0a5-741b-4d90-a187-79ff2d5262d0	t	${role_delete-account}	delete-account	68507cda-c551-4ae5-8e9b-474fc4f60060	2e36e0a5-741b-4d90-a187-79ff2d5262d0	\N
1e8d1e98-4d95-4043-bee8-ee5db23ba73a	2e36e0a5-741b-4d90-a187-79ff2d5262d0	t	${role_manage-consent}	manage-consent	68507cda-c551-4ae5-8e9b-474fc4f60060	2e36e0a5-741b-4d90-a187-79ff2d5262d0	\N
1b6a6b3f-bbd9-4cb1-b2d5-187dbe7240b0	2e36e0a5-741b-4d90-a187-79ff2d5262d0	t	${role_view-applications}	view-applications	68507cda-c551-4ae5-8e9b-474fc4f60060	2e36e0a5-741b-4d90-a187-79ff2d5262d0	\N
d6b0691e-245f-436a-83ed-a46b07bdd08a	2e36e0a5-741b-4d90-a187-79ff2d5262d0	t	${role_view-groups}	view-groups	68507cda-c551-4ae5-8e9b-474fc4f60060	2e36e0a5-741b-4d90-a187-79ff2d5262d0	\N
6b1873ae-f97e-40e8-8c16-a85559b784ab	2e36e0a5-741b-4d90-a187-79ff2d5262d0	t	${role_manage-account}	manage-account	68507cda-c551-4ae5-8e9b-474fc4f60060	2e36e0a5-741b-4d90-a187-79ff2d5262d0	\N
5cac6c81-3400-4661-a5d6-a7bf50604118	2e36e0a5-741b-4d90-a187-79ff2d5262d0	t	${role_view-consent}	view-consent	68507cda-c551-4ae5-8e9b-474fc4f60060	2e36e0a5-741b-4d90-a187-79ff2d5262d0	\N
d61f4850-64ba-42d5-8790-190dfc3016b3	2e36e0a5-741b-4d90-a187-79ff2d5262d0	t	${role_view-profile}	view-profile	68507cda-c551-4ae5-8e9b-474fc4f60060	2e36e0a5-741b-4d90-a187-79ff2d5262d0	\N
ce5401bb-db61-4722-a671-98725d7c676a	2e36e0a5-741b-4d90-a187-79ff2d5262d0	t	${role_manage-account-links}	manage-account-links	68507cda-c551-4ae5-8e9b-474fc4f60060	2e36e0a5-741b-4d90-a187-79ff2d5262d0	\N
b382a4b6-fb8b-4f69-bf12-e70b99d138aa	1499cf0a-a797-46f4-ae55-f7a762ee295a	t	${role_impersonation}	impersonation	7aa9c96c-04c3-424e-8bf5-94873e7e3275	1499cf0a-a797-46f4-ae55-f7a762ee295a	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.migration_model (id, version, update_time) FROM stdin;
ddexi	20.0.0	1668425132
ohslp	24.0.5	1717780637
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh) FROM stdin;
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
f4e39552-9e45-418a-9d22-a45c0387eb95	audience resolve	openid-connect	oidc-audience-resolve-mapper	72bc2e99-9371-4f71-a6ef-02d95ae5d000	\N
68db302a-0ccc-42de-9977-3f45921bb733	locale	openid-connect	oidc-usermodel-attribute-mapper	4ec0fb2f-b504-45f9-9329-cf0a9b44f3b7	\N
15e0fe84-75e9-413e-9199-22333edcc962	role list	saml	saml-role-list-mapper	\N	604b586b-a4a0-4798-936d-acb761f39acf
5710c624-ded1-4631-aa7d-6a0d15354e9f	full name	openid-connect	oidc-full-name-mapper	\N	fd497d05-e3f5-4932-b76d-1c0a76c651f3
99251cb0-749a-4f4e-9eda-2c6bfc49eca9	family name	openid-connect	oidc-usermodel-property-mapper	\N	fd497d05-e3f5-4932-b76d-1c0a76c651f3
6f26a91f-353a-4511-a40a-4ed9121fc3bf	given name	openid-connect	oidc-usermodel-property-mapper	\N	fd497d05-e3f5-4932-b76d-1c0a76c651f3
0f47a5bc-cbf5-44c8-a756-e326c933d980	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	fd497d05-e3f5-4932-b76d-1c0a76c651f3
0cf83a1c-103e-4367-a1d7-d9d1b1c9908b	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	fd497d05-e3f5-4932-b76d-1c0a76c651f3
a71d63ef-0f9e-47fd-9ad1-c83c0f6d9c3d	username	openid-connect	oidc-usermodel-property-mapper	\N	fd497d05-e3f5-4932-b76d-1c0a76c651f3
ea5dff45-6760-4f8f-9023-635eaf488bff	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	fd497d05-e3f5-4932-b76d-1c0a76c651f3
bf10bda4-dce0-427f-9f15-701e62a89f87	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	fd497d05-e3f5-4932-b76d-1c0a76c651f3
45f4ee5a-2bc1-4c67-ba7f-eec47c2b9cdc	website	openid-connect	oidc-usermodel-attribute-mapper	\N	fd497d05-e3f5-4932-b76d-1c0a76c651f3
b6f2d459-30f3-4d22-888e-7749faabd206	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	fd497d05-e3f5-4932-b76d-1c0a76c651f3
254a40f9-61ab-4074-a043-905da1262474	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	fd497d05-e3f5-4932-b76d-1c0a76c651f3
53bfc507-e1ce-4be9-b374-dae1af5b2a21	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	fd497d05-e3f5-4932-b76d-1c0a76c651f3
6cf6842a-f3e7-4d34-9199-ebfd7209fcc9	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	fd497d05-e3f5-4932-b76d-1c0a76c651f3
7edfb1f8-01ec-4328-9979-9424ec3a89af	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	fd497d05-e3f5-4932-b76d-1c0a76c651f3
a6d5b299-1be6-4608-893c-4ca9eb716b1e	email	openid-connect	oidc-usermodel-property-mapper	\N	3cc9757b-d962-4f88-9da1-d7f8274a4365
35b5d82c-7d75-4b47-8f92-8a7fc3e18238	email verified	openid-connect	oidc-usermodel-property-mapper	\N	3cc9757b-d962-4f88-9da1-d7f8274a4365
cb1eead2-ad8b-464b-9a49-ec8d16688b4b	address	openid-connect	oidc-address-mapper	\N	1d720f36-9829-4030-aa69-aa06b2782285
d5cffcb0-f442-49d3-8081-c549a19bec0e	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	a3728da9-a45a-4937-9f81-dfac2a95f2bc
cb21562e-39bc-4a8c-88e3-d7f41bc81aaa	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	a3728da9-a45a-4937-9f81-dfac2a95f2bc
912357dd-aa64-4691-9845-cfe107a9e9b6	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	943bc85e-622f-4d58-af01-f722a64a69a2
99a378f1-1ff4-49ba-b3ba-016d97101f5d	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	943bc85e-622f-4d58-af01-f722a64a69a2
798838a5-1091-448a-a4db-94db160c4d81	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	943bc85e-622f-4d58-af01-f722a64a69a2
bbbd91bc-7dde-4c0b-a85e-d15c138c3682	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	90e717d8-7122-49d8-8fdf-4cb9bbc54c0e
e965a80f-7c4a-4a77-8e0c-ff6d61328222	upn	openid-connect	oidc-usermodel-property-mapper	\N	58c8c8ff-d76a-43b2-bf22-352ca81e77b1
af283442-a25d-4fcb-b16d-e2d5b18a46e4	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	58c8c8ff-d76a-43b2-bf22-352ca81e77b1
ef146250-3c72-4918-8c34-1cabe896ce21	acr loa level	openid-connect	oidc-acr-mapper	\N	bcafe427-ccd8-4b4b-a6a1-3d26ce88bb77
7e9be65f-b59b-4f3f-9059-32e927947c87	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	56f50926-caf1-438e-aa91-299a94aad2f6
7f7b4686-3047-4fee-94e3-721eced98bd3	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	56f50926-caf1-438e-aa91-299a94aad2f6
e62f1491-7bfe-45af-8420-4f57a25dcd9a	full name	openid-connect	oidc-full-name-mapper	\N	56f50926-caf1-438e-aa91-299a94aad2f6
0c8bb413-87e4-4244-892f-64e11183ff35	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	56f50926-caf1-438e-aa91-299a94aad2f6
48f29fe5-18a3-4ff3-ae01-43a030756758	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	56f50926-caf1-438e-aa91-299a94aad2f6
36719714-2d91-40ce-9041-9827ef92a3f1	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	56f50926-caf1-438e-aa91-299a94aad2f6
4214c243-abce-417b-bae4-edc677eb8a97	given name	openid-connect	oidc-usermodel-property-mapper	\N	56f50926-caf1-438e-aa91-299a94aad2f6
dc43d25e-ba0e-4daa-976f-6601f4b3bfbf	username	openid-connect	oidc-usermodel-property-mapper	\N	56f50926-caf1-438e-aa91-299a94aad2f6
2af0a0c1-81ad-477e-b3f2-e9f03b2da5e0	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	56f50926-caf1-438e-aa91-299a94aad2f6
3871a3c6-10dd-4363-a1f4-454f4b8817ec	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	56f50926-caf1-438e-aa91-299a94aad2f6
402b82a8-0ff7-4c27-9f6c-c8cf8010d277	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	56f50926-caf1-438e-aa91-299a94aad2f6
7891a85a-039c-42ff-9e3f-3633a342ac1a	website	openid-connect	oidc-usermodel-attribute-mapper	\N	56f50926-caf1-438e-aa91-299a94aad2f6
de51afb8-31f3-454f-acd4-d7906945cc0e	family name	openid-connect	oidc-usermodel-property-mapper	\N	56f50926-caf1-438e-aa91-299a94aad2f6
92ed65ba-f9cd-4a20-b765-15fb327a5875	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	56f50926-caf1-438e-aa91-299a94aad2f6
f72cdc2b-36c5-43e3-a85d-ecc6f52411ab	role list	saml	saml-role-list-mapper	\N	cf45d72f-4857-4106-953e-487ed89f4b65
0ac744da-110e-4580-8490-66d002ed1233	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	c5072f00-890e-41a3-8fec-3f2276ee765a
925d81b5-1a4b-48fc-91d3-342dde08c5f9	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	c5072f00-890e-41a3-8fec-3f2276ee765a
25d17906-3f9d-4b3b-83ef-73d02da5c10f	email	openid-connect	oidc-usermodel-property-mapper	\N	c6b2bc7d-050e-423a-b6e1-d85206e66ab6
74df6f94-7517-4901-86e8-3e91cb8f53ea	email verified	openid-connect	oidc-usermodel-property-mapper	\N	c6b2bc7d-050e-423a-b6e1-d85206e66ab6
a8b9d4cb-5c2d-45d1-9213-62056e09f89a	acr loa level	openid-connect	oidc-acr-mapper	\N	b44476bf-b17b-4571-84d7-1cd18161766e
6b64bff5-7612-4bf0-9196-a95618965e05	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	789f9eaa-ba68-4f07-ae85-0e7d70235c9c
a4caf1f4-f120-4e58-b7a6-bdce0d9ad90a	address	openid-connect	oidc-address-mapper	\N	1956f6f1-1bea-4afa-998b-ed36c4de5640
8b2d12ad-f69a-40e3-9046-face7fcdfb6c	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	05aeab96-1872-4724-b68a-92ad0ed90189
e3fcb8d3-e677-4072-95f0-229c6a276b86	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	05aeab96-1872-4724-b68a-92ad0ed90189
1a547442-a808-497d-8b7b-2a14f53ee60f	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	05aeab96-1872-4724-b68a-92ad0ed90189
122a9a4e-d64c-454e-935d-d75afb26bff3	upn	openid-connect	oidc-usermodel-property-mapper	\N	395eea87-4dde-4f6c-9c61-9da6fb8a9f67
33bca7ec-f50e-4de4-a72e-0971a4b2ae74	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	395eea87-4dde-4f6c-9c61-9da6fb8a9f67
5f1ade2a-ddde-45b9-981f-9c642841806c	audience resolve	openid-connect	oidc-audience-resolve-mapper	cec23f3d-0c0d-4446-b19d-777fa17d97c9	\N
f81c39c6-f0dd-45ab-a085-56f4c84a6dcb	locale	openid-connect	oidc-usermodel-attribute-mapper	e450d026-67e5-4609-a564-0d272cbb7826	\N
024f5b69-230d-4dad-8a25-93d64c7be947	A mapper to issue the example API's audience	openid-connect	oidc-audience-mapper	\N	56f50926-caf1-438e-aa91-299a94aad2f6
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
68db302a-0ccc-42de-9977-3f45921bb733	true	userinfo.token.claim
68db302a-0ccc-42de-9977-3f45921bb733	locale	user.attribute
68db302a-0ccc-42de-9977-3f45921bb733	true	id.token.claim
68db302a-0ccc-42de-9977-3f45921bb733	true	access.token.claim
68db302a-0ccc-42de-9977-3f45921bb733	locale	claim.name
68db302a-0ccc-42de-9977-3f45921bb733	String	jsonType.label
15e0fe84-75e9-413e-9199-22333edcc962	false	single
15e0fe84-75e9-413e-9199-22333edcc962	Basic	attribute.nameformat
15e0fe84-75e9-413e-9199-22333edcc962	Role	attribute.name
0cf83a1c-103e-4367-a1d7-d9d1b1c9908b	true	userinfo.token.claim
0cf83a1c-103e-4367-a1d7-d9d1b1c9908b	nickname	user.attribute
0cf83a1c-103e-4367-a1d7-d9d1b1c9908b	true	id.token.claim
0cf83a1c-103e-4367-a1d7-d9d1b1c9908b	true	access.token.claim
0cf83a1c-103e-4367-a1d7-d9d1b1c9908b	nickname	claim.name
0cf83a1c-103e-4367-a1d7-d9d1b1c9908b	String	jsonType.label
0f47a5bc-cbf5-44c8-a756-e326c933d980	true	userinfo.token.claim
0f47a5bc-cbf5-44c8-a756-e326c933d980	middleName	user.attribute
0f47a5bc-cbf5-44c8-a756-e326c933d980	true	id.token.claim
0f47a5bc-cbf5-44c8-a756-e326c933d980	true	access.token.claim
0f47a5bc-cbf5-44c8-a756-e326c933d980	middle_name	claim.name
0f47a5bc-cbf5-44c8-a756-e326c933d980	String	jsonType.label
254a40f9-61ab-4074-a043-905da1262474	true	userinfo.token.claim
254a40f9-61ab-4074-a043-905da1262474	birthdate	user.attribute
254a40f9-61ab-4074-a043-905da1262474	true	id.token.claim
254a40f9-61ab-4074-a043-905da1262474	true	access.token.claim
254a40f9-61ab-4074-a043-905da1262474	birthdate	claim.name
254a40f9-61ab-4074-a043-905da1262474	String	jsonType.label
45f4ee5a-2bc1-4c67-ba7f-eec47c2b9cdc	true	userinfo.token.claim
45f4ee5a-2bc1-4c67-ba7f-eec47c2b9cdc	website	user.attribute
45f4ee5a-2bc1-4c67-ba7f-eec47c2b9cdc	true	id.token.claim
45f4ee5a-2bc1-4c67-ba7f-eec47c2b9cdc	true	access.token.claim
45f4ee5a-2bc1-4c67-ba7f-eec47c2b9cdc	website	claim.name
45f4ee5a-2bc1-4c67-ba7f-eec47c2b9cdc	String	jsonType.label
53bfc507-e1ce-4be9-b374-dae1af5b2a21	true	userinfo.token.claim
53bfc507-e1ce-4be9-b374-dae1af5b2a21	zoneinfo	user.attribute
53bfc507-e1ce-4be9-b374-dae1af5b2a21	true	id.token.claim
53bfc507-e1ce-4be9-b374-dae1af5b2a21	true	access.token.claim
53bfc507-e1ce-4be9-b374-dae1af5b2a21	zoneinfo	claim.name
53bfc507-e1ce-4be9-b374-dae1af5b2a21	String	jsonType.label
5710c624-ded1-4631-aa7d-6a0d15354e9f	true	userinfo.token.claim
5710c624-ded1-4631-aa7d-6a0d15354e9f	true	id.token.claim
5710c624-ded1-4631-aa7d-6a0d15354e9f	true	access.token.claim
6cf6842a-f3e7-4d34-9199-ebfd7209fcc9	true	userinfo.token.claim
6cf6842a-f3e7-4d34-9199-ebfd7209fcc9	locale	user.attribute
6cf6842a-f3e7-4d34-9199-ebfd7209fcc9	true	id.token.claim
6cf6842a-f3e7-4d34-9199-ebfd7209fcc9	true	access.token.claim
6cf6842a-f3e7-4d34-9199-ebfd7209fcc9	locale	claim.name
6cf6842a-f3e7-4d34-9199-ebfd7209fcc9	String	jsonType.label
6f26a91f-353a-4511-a40a-4ed9121fc3bf	true	userinfo.token.claim
6f26a91f-353a-4511-a40a-4ed9121fc3bf	firstName	user.attribute
6f26a91f-353a-4511-a40a-4ed9121fc3bf	true	id.token.claim
6f26a91f-353a-4511-a40a-4ed9121fc3bf	true	access.token.claim
6f26a91f-353a-4511-a40a-4ed9121fc3bf	given_name	claim.name
6f26a91f-353a-4511-a40a-4ed9121fc3bf	String	jsonType.label
7edfb1f8-01ec-4328-9979-9424ec3a89af	true	userinfo.token.claim
7edfb1f8-01ec-4328-9979-9424ec3a89af	updatedAt	user.attribute
7edfb1f8-01ec-4328-9979-9424ec3a89af	true	id.token.claim
7edfb1f8-01ec-4328-9979-9424ec3a89af	true	access.token.claim
7edfb1f8-01ec-4328-9979-9424ec3a89af	updated_at	claim.name
7edfb1f8-01ec-4328-9979-9424ec3a89af	long	jsonType.label
99251cb0-749a-4f4e-9eda-2c6bfc49eca9	true	userinfo.token.claim
99251cb0-749a-4f4e-9eda-2c6bfc49eca9	lastName	user.attribute
99251cb0-749a-4f4e-9eda-2c6bfc49eca9	true	id.token.claim
99251cb0-749a-4f4e-9eda-2c6bfc49eca9	true	access.token.claim
99251cb0-749a-4f4e-9eda-2c6bfc49eca9	family_name	claim.name
99251cb0-749a-4f4e-9eda-2c6bfc49eca9	String	jsonType.label
a71d63ef-0f9e-47fd-9ad1-c83c0f6d9c3d	true	userinfo.token.claim
a71d63ef-0f9e-47fd-9ad1-c83c0f6d9c3d	username	user.attribute
a71d63ef-0f9e-47fd-9ad1-c83c0f6d9c3d	true	id.token.claim
a71d63ef-0f9e-47fd-9ad1-c83c0f6d9c3d	true	access.token.claim
a71d63ef-0f9e-47fd-9ad1-c83c0f6d9c3d	preferred_username	claim.name
a71d63ef-0f9e-47fd-9ad1-c83c0f6d9c3d	String	jsonType.label
b6f2d459-30f3-4d22-888e-7749faabd206	true	userinfo.token.claim
b6f2d459-30f3-4d22-888e-7749faabd206	gender	user.attribute
b6f2d459-30f3-4d22-888e-7749faabd206	true	id.token.claim
b6f2d459-30f3-4d22-888e-7749faabd206	true	access.token.claim
b6f2d459-30f3-4d22-888e-7749faabd206	gender	claim.name
b6f2d459-30f3-4d22-888e-7749faabd206	String	jsonType.label
bf10bda4-dce0-427f-9f15-701e62a89f87	true	userinfo.token.claim
bf10bda4-dce0-427f-9f15-701e62a89f87	picture	user.attribute
bf10bda4-dce0-427f-9f15-701e62a89f87	true	id.token.claim
bf10bda4-dce0-427f-9f15-701e62a89f87	true	access.token.claim
bf10bda4-dce0-427f-9f15-701e62a89f87	picture	claim.name
bf10bda4-dce0-427f-9f15-701e62a89f87	String	jsonType.label
ea5dff45-6760-4f8f-9023-635eaf488bff	true	userinfo.token.claim
ea5dff45-6760-4f8f-9023-635eaf488bff	profile	user.attribute
ea5dff45-6760-4f8f-9023-635eaf488bff	true	id.token.claim
ea5dff45-6760-4f8f-9023-635eaf488bff	true	access.token.claim
ea5dff45-6760-4f8f-9023-635eaf488bff	profile	claim.name
ea5dff45-6760-4f8f-9023-635eaf488bff	String	jsonType.label
35b5d82c-7d75-4b47-8f92-8a7fc3e18238	true	userinfo.token.claim
35b5d82c-7d75-4b47-8f92-8a7fc3e18238	emailVerified	user.attribute
35b5d82c-7d75-4b47-8f92-8a7fc3e18238	true	id.token.claim
35b5d82c-7d75-4b47-8f92-8a7fc3e18238	true	access.token.claim
35b5d82c-7d75-4b47-8f92-8a7fc3e18238	email_verified	claim.name
35b5d82c-7d75-4b47-8f92-8a7fc3e18238	boolean	jsonType.label
a6d5b299-1be6-4608-893c-4ca9eb716b1e	true	userinfo.token.claim
a6d5b299-1be6-4608-893c-4ca9eb716b1e	email	user.attribute
a6d5b299-1be6-4608-893c-4ca9eb716b1e	true	id.token.claim
a6d5b299-1be6-4608-893c-4ca9eb716b1e	true	access.token.claim
a6d5b299-1be6-4608-893c-4ca9eb716b1e	email	claim.name
a6d5b299-1be6-4608-893c-4ca9eb716b1e	String	jsonType.label
cb1eead2-ad8b-464b-9a49-ec8d16688b4b	formatted	user.attribute.formatted
cb1eead2-ad8b-464b-9a49-ec8d16688b4b	country	user.attribute.country
cb1eead2-ad8b-464b-9a49-ec8d16688b4b	postal_code	user.attribute.postal_code
cb1eead2-ad8b-464b-9a49-ec8d16688b4b	true	userinfo.token.claim
cb1eead2-ad8b-464b-9a49-ec8d16688b4b	street	user.attribute.street
cb1eead2-ad8b-464b-9a49-ec8d16688b4b	true	id.token.claim
cb1eead2-ad8b-464b-9a49-ec8d16688b4b	region	user.attribute.region
cb1eead2-ad8b-464b-9a49-ec8d16688b4b	true	access.token.claim
cb1eead2-ad8b-464b-9a49-ec8d16688b4b	locality	user.attribute.locality
cb21562e-39bc-4a8c-88e3-d7f41bc81aaa	true	userinfo.token.claim
cb21562e-39bc-4a8c-88e3-d7f41bc81aaa	phoneNumberVerified	user.attribute
cb21562e-39bc-4a8c-88e3-d7f41bc81aaa	true	id.token.claim
cb21562e-39bc-4a8c-88e3-d7f41bc81aaa	true	access.token.claim
cb21562e-39bc-4a8c-88e3-d7f41bc81aaa	phone_number_verified	claim.name
cb21562e-39bc-4a8c-88e3-d7f41bc81aaa	boolean	jsonType.label
d5cffcb0-f442-49d3-8081-c549a19bec0e	true	userinfo.token.claim
d5cffcb0-f442-49d3-8081-c549a19bec0e	phoneNumber	user.attribute
d5cffcb0-f442-49d3-8081-c549a19bec0e	true	id.token.claim
d5cffcb0-f442-49d3-8081-c549a19bec0e	true	access.token.claim
d5cffcb0-f442-49d3-8081-c549a19bec0e	phone_number	claim.name
d5cffcb0-f442-49d3-8081-c549a19bec0e	String	jsonType.label
912357dd-aa64-4691-9845-cfe107a9e9b6	true	multivalued
912357dd-aa64-4691-9845-cfe107a9e9b6	foo	user.attribute
912357dd-aa64-4691-9845-cfe107a9e9b6	true	access.token.claim
912357dd-aa64-4691-9845-cfe107a9e9b6	realm_access.roles	claim.name
912357dd-aa64-4691-9845-cfe107a9e9b6	String	jsonType.label
99a378f1-1ff4-49ba-b3ba-016d97101f5d	true	multivalued
99a378f1-1ff4-49ba-b3ba-016d97101f5d	foo	user.attribute
99a378f1-1ff4-49ba-b3ba-016d97101f5d	true	access.token.claim
99a378f1-1ff4-49ba-b3ba-016d97101f5d	resource_access.${client_id}.roles	claim.name
99a378f1-1ff4-49ba-b3ba-016d97101f5d	String	jsonType.label
af283442-a25d-4fcb-b16d-e2d5b18a46e4	true	multivalued
af283442-a25d-4fcb-b16d-e2d5b18a46e4	foo	user.attribute
af283442-a25d-4fcb-b16d-e2d5b18a46e4	true	id.token.claim
af283442-a25d-4fcb-b16d-e2d5b18a46e4	true	access.token.claim
af283442-a25d-4fcb-b16d-e2d5b18a46e4	groups	claim.name
af283442-a25d-4fcb-b16d-e2d5b18a46e4	String	jsonType.label
e965a80f-7c4a-4a77-8e0c-ff6d61328222	true	userinfo.token.claim
e965a80f-7c4a-4a77-8e0c-ff6d61328222	username	user.attribute
e965a80f-7c4a-4a77-8e0c-ff6d61328222	true	id.token.claim
e965a80f-7c4a-4a77-8e0c-ff6d61328222	true	access.token.claim
e965a80f-7c4a-4a77-8e0c-ff6d61328222	upn	claim.name
e965a80f-7c4a-4a77-8e0c-ff6d61328222	String	jsonType.label
ef146250-3c72-4918-8c34-1cabe896ce21	true	id.token.claim
ef146250-3c72-4918-8c34-1cabe896ce21	true	access.token.claim
0c8bb413-87e4-4244-892f-64e11183ff35	true	userinfo.token.claim
0c8bb413-87e4-4244-892f-64e11183ff35	gender	user.attribute
0c8bb413-87e4-4244-892f-64e11183ff35	true	id.token.claim
0c8bb413-87e4-4244-892f-64e11183ff35	true	access.token.claim
0c8bb413-87e4-4244-892f-64e11183ff35	gender	claim.name
0c8bb413-87e4-4244-892f-64e11183ff35	String	jsonType.label
2af0a0c1-81ad-477e-b3f2-e9f03b2da5e0	true	userinfo.token.claim
2af0a0c1-81ad-477e-b3f2-e9f03b2da5e0	locale	user.attribute
2af0a0c1-81ad-477e-b3f2-e9f03b2da5e0	true	id.token.claim
2af0a0c1-81ad-477e-b3f2-e9f03b2da5e0	true	access.token.claim
2af0a0c1-81ad-477e-b3f2-e9f03b2da5e0	locale	claim.name
2af0a0c1-81ad-477e-b3f2-e9f03b2da5e0	String	jsonType.label
36719714-2d91-40ce-9041-9827ef92a3f1	true	userinfo.token.claim
36719714-2d91-40ce-9041-9827ef92a3f1	picture	user.attribute
36719714-2d91-40ce-9041-9827ef92a3f1	true	id.token.claim
36719714-2d91-40ce-9041-9827ef92a3f1	true	access.token.claim
36719714-2d91-40ce-9041-9827ef92a3f1	picture	claim.name
36719714-2d91-40ce-9041-9827ef92a3f1	String	jsonType.label
3871a3c6-10dd-4363-a1f4-454f4b8817ec	true	userinfo.token.claim
3871a3c6-10dd-4363-a1f4-454f4b8817ec	nickname	user.attribute
3871a3c6-10dd-4363-a1f4-454f4b8817ec	true	id.token.claim
3871a3c6-10dd-4363-a1f4-454f4b8817ec	true	access.token.claim
3871a3c6-10dd-4363-a1f4-454f4b8817ec	nickname	claim.name
3871a3c6-10dd-4363-a1f4-454f4b8817ec	String	jsonType.label
402b82a8-0ff7-4c27-9f6c-c8cf8010d277	true	userinfo.token.claim
402b82a8-0ff7-4c27-9f6c-c8cf8010d277	zoneinfo	user.attribute
402b82a8-0ff7-4c27-9f6c-c8cf8010d277	true	id.token.claim
402b82a8-0ff7-4c27-9f6c-c8cf8010d277	true	access.token.claim
402b82a8-0ff7-4c27-9f6c-c8cf8010d277	zoneinfo	claim.name
402b82a8-0ff7-4c27-9f6c-c8cf8010d277	String	jsonType.label
4214c243-abce-417b-bae4-edc677eb8a97	true	userinfo.token.claim
4214c243-abce-417b-bae4-edc677eb8a97	firstName	user.attribute
4214c243-abce-417b-bae4-edc677eb8a97	true	id.token.claim
4214c243-abce-417b-bae4-edc677eb8a97	true	access.token.claim
4214c243-abce-417b-bae4-edc677eb8a97	given_name	claim.name
4214c243-abce-417b-bae4-edc677eb8a97	String	jsonType.label
48f29fe5-18a3-4ff3-ae01-43a030756758	true	userinfo.token.claim
48f29fe5-18a3-4ff3-ae01-43a030756758	birthdate	user.attribute
48f29fe5-18a3-4ff3-ae01-43a030756758	true	id.token.claim
48f29fe5-18a3-4ff3-ae01-43a030756758	true	access.token.claim
48f29fe5-18a3-4ff3-ae01-43a030756758	birthdate	claim.name
48f29fe5-18a3-4ff3-ae01-43a030756758	String	jsonType.label
7891a85a-039c-42ff-9e3f-3633a342ac1a	true	userinfo.token.claim
7891a85a-039c-42ff-9e3f-3633a342ac1a	website	user.attribute
7891a85a-039c-42ff-9e3f-3633a342ac1a	true	id.token.claim
7891a85a-039c-42ff-9e3f-3633a342ac1a	true	access.token.claim
7891a85a-039c-42ff-9e3f-3633a342ac1a	website	claim.name
7891a85a-039c-42ff-9e3f-3633a342ac1a	String	jsonType.label
7e9be65f-b59b-4f3f-9059-32e927947c87	true	userinfo.token.claim
7e9be65f-b59b-4f3f-9059-32e927947c87	middleName	user.attribute
7e9be65f-b59b-4f3f-9059-32e927947c87	true	id.token.claim
7e9be65f-b59b-4f3f-9059-32e927947c87	true	access.token.claim
7e9be65f-b59b-4f3f-9059-32e927947c87	middle_name	claim.name
7e9be65f-b59b-4f3f-9059-32e927947c87	String	jsonType.label
7f7b4686-3047-4fee-94e3-721eced98bd3	true	userinfo.token.claim
7f7b4686-3047-4fee-94e3-721eced98bd3	profile	user.attribute
7f7b4686-3047-4fee-94e3-721eced98bd3	true	id.token.claim
7f7b4686-3047-4fee-94e3-721eced98bd3	true	access.token.claim
7f7b4686-3047-4fee-94e3-721eced98bd3	profile	claim.name
7f7b4686-3047-4fee-94e3-721eced98bd3	String	jsonType.label
92ed65ba-f9cd-4a20-b765-15fb327a5875	true	userinfo.token.claim
92ed65ba-f9cd-4a20-b765-15fb327a5875	updatedAt	user.attribute
92ed65ba-f9cd-4a20-b765-15fb327a5875	true	id.token.claim
92ed65ba-f9cd-4a20-b765-15fb327a5875	true	access.token.claim
92ed65ba-f9cd-4a20-b765-15fb327a5875	updated_at	claim.name
92ed65ba-f9cd-4a20-b765-15fb327a5875	long	jsonType.label
dc43d25e-ba0e-4daa-976f-6601f4b3bfbf	true	userinfo.token.claim
dc43d25e-ba0e-4daa-976f-6601f4b3bfbf	username	user.attribute
dc43d25e-ba0e-4daa-976f-6601f4b3bfbf	true	id.token.claim
dc43d25e-ba0e-4daa-976f-6601f4b3bfbf	true	access.token.claim
dc43d25e-ba0e-4daa-976f-6601f4b3bfbf	preferred_username	claim.name
dc43d25e-ba0e-4daa-976f-6601f4b3bfbf	String	jsonType.label
de51afb8-31f3-454f-acd4-d7906945cc0e	true	userinfo.token.claim
de51afb8-31f3-454f-acd4-d7906945cc0e	lastName	user.attribute
de51afb8-31f3-454f-acd4-d7906945cc0e	true	id.token.claim
de51afb8-31f3-454f-acd4-d7906945cc0e	true	access.token.claim
de51afb8-31f3-454f-acd4-d7906945cc0e	family_name	claim.name
de51afb8-31f3-454f-acd4-d7906945cc0e	String	jsonType.label
e62f1491-7bfe-45af-8420-4f57a25dcd9a	true	id.token.claim
e62f1491-7bfe-45af-8420-4f57a25dcd9a	true	access.token.claim
e62f1491-7bfe-45af-8420-4f57a25dcd9a	true	userinfo.token.claim
f72cdc2b-36c5-43e3-a85d-ecc6f52411ab	false	single
f72cdc2b-36c5-43e3-a85d-ecc6f52411ab	Basic	attribute.nameformat
f72cdc2b-36c5-43e3-a85d-ecc6f52411ab	Role	attribute.name
0ac744da-110e-4580-8490-66d002ed1233	true	userinfo.token.claim
0ac744da-110e-4580-8490-66d002ed1233	phoneNumberVerified	user.attribute
0ac744da-110e-4580-8490-66d002ed1233	true	id.token.claim
0ac744da-110e-4580-8490-66d002ed1233	true	access.token.claim
0ac744da-110e-4580-8490-66d002ed1233	phone_number_verified	claim.name
0ac744da-110e-4580-8490-66d002ed1233	boolean	jsonType.label
925d81b5-1a4b-48fc-91d3-342dde08c5f9	true	userinfo.token.claim
925d81b5-1a4b-48fc-91d3-342dde08c5f9	phoneNumber	user.attribute
925d81b5-1a4b-48fc-91d3-342dde08c5f9	true	id.token.claim
925d81b5-1a4b-48fc-91d3-342dde08c5f9	true	access.token.claim
925d81b5-1a4b-48fc-91d3-342dde08c5f9	phone_number	claim.name
925d81b5-1a4b-48fc-91d3-342dde08c5f9	String	jsonType.label
25d17906-3f9d-4b3b-83ef-73d02da5c10f	true	userinfo.token.claim
25d17906-3f9d-4b3b-83ef-73d02da5c10f	email	user.attribute
25d17906-3f9d-4b3b-83ef-73d02da5c10f	true	id.token.claim
25d17906-3f9d-4b3b-83ef-73d02da5c10f	true	access.token.claim
25d17906-3f9d-4b3b-83ef-73d02da5c10f	email	claim.name
25d17906-3f9d-4b3b-83ef-73d02da5c10f	String	jsonType.label
74df6f94-7517-4901-86e8-3e91cb8f53ea	true	userinfo.token.claim
74df6f94-7517-4901-86e8-3e91cb8f53ea	emailVerified	user.attribute
74df6f94-7517-4901-86e8-3e91cb8f53ea	true	id.token.claim
74df6f94-7517-4901-86e8-3e91cb8f53ea	true	access.token.claim
74df6f94-7517-4901-86e8-3e91cb8f53ea	email_verified	claim.name
74df6f94-7517-4901-86e8-3e91cb8f53ea	boolean	jsonType.label
a8b9d4cb-5c2d-45d1-9213-62056e09f89a	true	id.token.claim
a8b9d4cb-5c2d-45d1-9213-62056e09f89a	true	access.token.claim
a8b9d4cb-5c2d-45d1-9213-62056e09f89a	true	userinfo.token.claim
a4caf1f4-f120-4e58-b7a6-bdce0d9ad90a	formatted	user.attribute.formatted
a4caf1f4-f120-4e58-b7a6-bdce0d9ad90a	country	user.attribute.country
a4caf1f4-f120-4e58-b7a6-bdce0d9ad90a	postal_code	user.attribute.postal_code
a4caf1f4-f120-4e58-b7a6-bdce0d9ad90a	true	userinfo.token.claim
a4caf1f4-f120-4e58-b7a6-bdce0d9ad90a	street	user.attribute.street
a4caf1f4-f120-4e58-b7a6-bdce0d9ad90a	true	id.token.claim
a4caf1f4-f120-4e58-b7a6-bdce0d9ad90a	region	user.attribute.region
a4caf1f4-f120-4e58-b7a6-bdce0d9ad90a	true	access.token.claim
a4caf1f4-f120-4e58-b7a6-bdce0d9ad90a	locality	user.attribute.locality
1a547442-a808-497d-8b7b-2a14f53ee60f	foo	user.attribute
1a547442-a808-497d-8b7b-2a14f53ee60f	true	access.token.claim
1a547442-a808-497d-8b7b-2a14f53ee60f	realm_access.roles	claim.name
1a547442-a808-497d-8b7b-2a14f53ee60f	String	jsonType.label
1a547442-a808-497d-8b7b-2a14f53ee60f	true	multivalued
8b2d12ad-f69a-40e3-9046-face7fcdfb6c	foo	user.attribute
8b2d12ad-f69a-40e3-9046-face7fcdfb6c	true	access.token.claim
8b2d12ad-f69a-40e3-9046-face7fcdfb6c	resource_access.${client_id}.roles	claim.name
8b2d12ad-f69a-40e3-9046-face7fcdfb6c	String	jsonType.label
8b2d12ad-f69a-40e3-9046-face7fcdfb6c	true	multivalued
122a9a4e-d64c-454e-935d-d75afb26bff3	true	userinfo.token.claim
122a9a4e-d64c-454e-935d-d75afb26bff3	username	user.attribute
122a9a4e-d64c-454e-935d-d75afb26bff3	true	id.token.claim
122a9a4e-d64c-454e-935d-d75afb26bff3	true	access.token.claim
122a9a4e-d64c-454e-935d-d75afb26bff3	upn	claim.name
122a9a4e-d64c-454e-935d-d75afb26bff3	String	jsonType.label
33bca7ec-f50e-4de4-a72e-0971a4b2ae74	true	multivalued
33bca7ec-f50e-4de4-a72e-0971a4b2ae74	true	userinfo.token.claim
33bca7ec-f50e-4de4-a72e-0971a4b2ae74	foo	user.attribute
33bca7ec-f50e-4de4-a72e-0971a4b2ae74	true	id.token.claim
33bca7ec-f50e-4de4-a72e-0971a4b2ae74	true	access.token.claim
33bca7ec-f50e-4de4-a72e-0971a4b2ae74	groups	claim.name
33bca7ec-f50e-4de4-a72e-0971a4b2ae74	String	jsonType.label
f81c39c6-f0dd-45ab-a085-56f4c84a6dcb	true	userinfo.token.claim
f81c39c6-f0dd-45ab-a085-56f4c84a6dcb	locale	user.attribute
f81c39c6-f0dd-45ab-a085-56f4c84a6dcb	true	id.token.claim
f81c39c6-f0dd-45ab-a085-56f4c84a6dcb	true	access.token.claim
f81c39c6-f0dd-45ab-a085-56f4c84a6dcb	locale	claim.name
f81c39c6-f0dd-45ab-a085-56f4c84a6dcb	String	jsonType.label
024f5b69-230d-4dad-8a25-93d64c7be947	true	introspection.token.claim
024f5b69-230d-4dad-8a25-93d64c7be947	api.example.com	included.custom.audience
024f5b69-230d-4dad-8a25-93d64c7be947	false	id.token.claim
024f5b69-230d-4dad-8a25-93d64c7be947	false	lightweight.claim
024f5b69-230d-4dad-8a25-93d64c7be947	true	access.token.claim
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
7aa9c96c-04c3-424e-8bf5-94873e7e3275	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	75a512b0-fb5a-409d-aa9c-49ef04cdc299	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	994f8ab2-6b42-49b5-9dba-378f346d9f25	bf29764d-ab50-49be-93e6-6da303c8c1a3	a30e6232-d7bf-4925-8fa6-ded509a6b943	4ad402c9-e873-4196-a6bd-006ae9a99aac	42718a46-01e8-4573-ad53-5155dc0f20df	2592000	f	900	t	f	4a52b01d-7301-4418-891c-6b6490f6a65e	0	f	0	0	137b4a16-e5b8-4ac6-9ca3-0121e1f66f4e
68507cda-c551-4ae5-8e9b-474fc4f60060	60	300	300	\N	\N	\N	t	f	0	\N	example	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	1499cf0a-a797-46f4-ae55-f7a762ee295a	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	7e03d641-6c1a-46df-b0a1-6dc2094a9a0b	1ccaa0d8-806c-4cc3-9b55-822508582c0f	8b8eb1ae-cbba-4f5f-b6ba-71cead5d9927	bc66bf72-231a-4a4a-a547-2e70e0527f1b	146bdd15-653b-4851-89f1-40ce4060cff8	2592000	f	900	t	f	34c5e320-ea67-482f-adb2-ca8158065e8e	0	f	0	0	2d4a63df-b516-4663-8eb3-2bb54255b970
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly	7aa9c96c-04c3-424e-8bf5-94873e7e3275	
_browser_header.xContentTypeOptions	7aa9c96c-04c3-424e-8bf5-94873e7e3275	nosniff
_browser_header.xRobotsTag	7aa9c96c-04c3-424e-8bf5-94873e7e3275	none
_browser_header.xFrameOptions	7aa9c96c-04c3-424e-8bf5-94873e7e3275	SAMEORIGIN
_browser_header.contentSecurityPolicy	7aa9c96c-04c3-424e-8bf5-94873e7e3275	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	7aa9c96c-04c3-424e-8bf5-94873e7e3275	1; mode=block
_browser_header.strictTransportSecurity	7aa9c96c-04c3-424e-8bf5-94873e7e3275	max-age=31536000; includeSubDomains
bruteForceProtected	7aa9c96c-04c3-424e-8bf5-94873e7e3275	false
permanentLockout	7aa9c96c-04c3-424e-8bf5-94873e7e3275	false
maxFailureWaitSeconds	7aa9c96c-04c3-424e-8bf5-94873e7e3275	900
minimumQuickLoginWaitSeconds	7aa9c96c-04c3-424e-8bf5-94873e7e3275	60
waitIncrementSeconds	7aa9c96c-04c3-424e-8bf5-94873e7e3275	60
quickLoginCheckMilliSeconds	7aa9c96c-04c3-424e-8bf5-94873e7e3275	1000
maxDeltaTimeSeconds	7aa9c96c-04c3-424e-8bf5-94873e7e3275	43200
failureFactor	7aa9c96c-04c3-424e-8bf5-94873e7e3275	30
realmReusableOtpCode	7aa9c96c-04c3-424e-8bf5-94873e7e3275	false
displayName	7aa9c96c-04c3-424e-8bf5-94873e7e3275	Keycloak
displayNameHtml	7aa9c96c-04c3-424e-8bf5-94873e7e3275	<div class="kc-logo-text"><span>Keycloak</span></div>
defaultSignatureAlgorithm	7aa9c96c-04c3-424e-8bf5-94873e7e3275	RS256
offlineSessionMaxLifespanEnabled	7aa9c96c-04c3-424e-8bf5-94873e7e3275	false
offlineSessionMaxLifespan	7aa9c96c-04c3-424e-8bf5-94873e7e3275	5184000
_browser_header.contentSecurityPolicyReportOnly	68507cda-c551-4ae5-8e9b-474fc4f60060	
_browser_header.xContentTypeOptions	68507cda-c551-4ae5-8e9b-474fc4f60060	nosniff
_browser_header.xRobotsTag	68507cda-c551-4ae5-8e9b-474fc4f60060	none
_browser_header.xFrameOptions	68507cda-c551-4ae5-8e9b-474fc4f60060	SAMEORIGIN
_browser_header.contentSecurityPolicy	68507cda-c551-4ae5-8e9b-474fc4f60060	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	68507cda-c551-4ae5-8e9b-474fc4f60060	1; mode=block
_browser_header.strictTransportSecurity	68507cda-c551-4ae5-8e9b-474fc4f60060	max-age=31536000; includeSubDomains
bruteForceProtected	68507cda-c551-4ae5-8e9b-474fc4f60060	false
permanentLockout	68507cda-c551-4ae5-8e9b-474fc4f60060	false
maxFailureWaitSeconds	68507cda-c551-4ae5-8e9b-474fc4f60060	900
minimumQuickLoginWaitSeconds	68507cda-c551-4ae5-8e9b-474fc4f60060	60
waitIncrementSeconds	68507cda-c551-4ae5-8e9b-474fc4f60060	60
quickLoginCheckMilliSeconds	68507cda-c551-4ae5-8e9b-474fc4f60060	1000
maxDeltaTimeSeconds	68507cda-c551-4ae5-8e9b-474fc4f60060	43200
failureFactor	68507cda-c551-4ae5-8e9b-474fc4f60060	30
realmReusableOtpCode	68507cda-c551-4ae5-8e9b-474fc4f60060	false
defaultSignatureAlgorithm	68507cda-c551-4ae5-8e9b-474fc4f60060	RS256
offlineSessionMaxLifespanEnabled	68507cda-c551-4ae5-8e9b-474fc4f60060	false
offlineSessionMaxLifespan	68507cda-c551-4ae5-8e9b-474fc4f60060	5184000
clientSessionIdleTimeout	68507cda-c551-4ae5-8e9b-474fc4f60060	0
clientSessionMaxLifespan	68507cda-c551-4ae5-8e9b-474fc4f60060	0
clientOfflineSessionIdleTimeout	68507cda-c551-4ae5-8e9b-474fc4f60060	0
clientOfflineSessionMaxLifespan	68507cda-c551-4ae5-8e9b-474fc4f60060	0
actionTokenGeneratedByAdminLifespan	68507cda-c551-4ae5-8e9b-474fc4f60060	43200
actionTokenGeneratedByUserLifespan	68507cda-c551-4ae5-8e9b-474fc4f60060	300
oauth2DeviceCodeLifespan	68507cda-c551-4ae5-8e9b-474fc4f60060	600
oauth2DevicePollingInterval	68507cda-c551-4ae5-8e9b-474fc4f60060	5
webAuthnPolicyRpEntityName	68507cda-c551-4ae5-8e9b-474fc4f60060	keycloak
webAuthnPolicySignatureAlgorithms	68507cda-c551-4ae5-8e9b-474fc4f60060	ES256
webAuthnPolicyRpId	68507cda-c551-4ae5-8e9b-474fc4f60060	
webAuthnPolicyAttestationConveyancePreference	68507cda-c551-4ae5-8e9b-474fc4f60060	not specified
webAuthnPolicyAuthenticatorAttachment	68507cda-c551-4ae5-8e9b-474fc4f60060	not specified
webAuthnPolicyRequireResidentKey	68507cda-c551-4ae5-8e9b-474fc4f60060	not specified
webAuthnPolicyUserVerificationRequirement	68507cda-c551-4ae5-8e9b-474fc4f60060	not specified
webAuthnPolicyCreateTimeout	68507cda-c551-4ae5-8e9b-474fc4f60060	0
webAuthnPolicyAvoidSameAuthenticatorRegister	68507cda-c551-4ae5-8e9b-474fc4f60060	false
webAuthnPolicyRpEntityNamePasswordless	68507cda-c551-4ae5-8e9b-474fc4f60060	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	68507cda-c551-4ae5-8e9b-474fc4f60060	ES256
webAuthnPolicyRpIdPasswordless	68507cda-c551-4ae5-8e9b-474fc4f60060	
webAuthnPolicyAttestationConveyancePreferencePasswordless	68507cda-c551-4ae5-8e9b-474fc4f60060	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	68507cda-c551-4ae5-8e9b-474fc4f60060	not specified
webAuthnPolicyRequireResidentKeyPasswordless	68507cda-c551-4ae5-8e9b-474fc4f60060	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	68507cda-c551-4ae5-8e9b-474fc4f60060	not specified
webAuthnPolicyCreateTimeoutPasswordless	68507cda-c551-4ae5-8e9b-474fc4f60060	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	68507cda-c551-4ae5-8e9b-474fc4f60060	false
cibaBackchannelTokenDeliveryMode	68507cda-c551-4ae5-8e9b-474fc4f60060	poll
cibaExpiresIn	68507cda-c551-4ae5-8e9b-474fc4f60060	120
cibaInterval	68507cda-c551-4ae5-8e9b-474fc4f60060	5
cibaAuthRequestedUserHint	68507cda-c551-4ae5-8e9b-474fc4f60060	login_hint
parRequestUriLifespan	68507cda-c551-4ae5-8e9b-474fc4f60060	60
client-policies.profiles	68507cda-c551-4ae5-8e9b-474fc4f60060	{"profiles":[]}
client-policies.policies	68507cda-c551-4ae5-8e9b-474fc4f60060	{"policies":[]}
firstBrokerLoginFlowId	7aa9c96c-04c3-424e-8bf5-94873e7e3275	cc8a27ae-105a-4bf3-8aa8-a029d2f9f5d5
firstBrokerLoginFlowId	68507cda-c551-4ae5-8e9b-474fc4f60060	7c9b7abf-5e68-4be0-af9f-da80667d3407
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
7aa9c96c-04c3-424e-8bf5-94873e7e3275	jboss-logging
68507cda-c551-4ae5-8e9b-474fc4f60060	jboss-logging
\.


--
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	7aa9c96c-04c3-424e-8bf5-94873e7e3275
password	password	t	t	68507cda-c551-4ae5-8e9b-474fc4f60060
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.redirect_uris (client_id, value) FROM stdin;
aa841261-1c2f-4788-a9e7-74fac384acd8	/realms/master/account/*
72bc2e99-9371-4f71-a6ef-02d95ae5d000	/realms/master/account/*
4ec0fb2f-b504-45f9-9329-cf0a9b44f3b7	/admin/master/console/*
2e36e0a5-741b-4d90-a187-79ff2d5262d0	/realms/example/account/*
cec23f3d-0c0d-4446-b19d-777fa17d97c9	/realms/example/account/*
e450d026-67e5-4609-a564-0d272cbb7826	/admin/example/console/*
7986828f-facd-4ed8-977d-70ead9b49ff0	http://www.product.example/callback
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
65800c74-264b-49c8-a8dc-f025373ead7a	VERIFY_EMAIL	Verify Email	7aa9c96c-04c3-424e-8bf5-94873e7e3275	t	f	VERIFY_EMAIL	50
9aa4e202-4923-481d-aca5-5fe21d86b641	UPDATE_PROFILE	Update Profile	7aa9c96c-04c3-424e-8bf5-94873e7e3275	t	f	UPDATE_PROFILE	40
7ac0c8a9-2dba-44c2-81ed-27f9b4c95016	CONFIGURE_TOTP	Configure OTP	7aa9c96c-04c3-424e-8bf5-94873e7e3275	t	f	CONFIGURE_TOTP	10
9f31e7c2-709c-421d-9ba5-a1baac4646f5	UPDATE_PASSWORD	Update Password	7aa9c96c-04c3-424e-8bf5-94873e7e3275	t	f	UPDATE_PASSWORD	30
8a44b3e8-c37e-4afc-842b-8e466e01be1e	delete_account	Delete Account	7aa9c96c-04c3-424e-8bf5-94873e7e3275	f	f	delete_account	60
eee6798c-1e1c-4208-9f18-f06132e6e8ed	update_user_locale	Update User Locale	7aa9c96c-04c3-424e-8bf5-94873e7e3275	t	f	update_user_locale	1000
6a8dffa2-8144-4e91-8285-d25daaa606bc	webauthn-register	Webauthn Register	7aa9c96c-04c3-424e-8bf5-94873e7e3275	t	f	webauthn-register	70
99f52d08-0d37-46cb-b0f4-e06fd8ffb2c5	webauthn-register-passwordless	Webauthn Register Passwordless	7aa9c96c-04c3-424e-8bf5-94873e7e3275	t	f	webauthn-register-passwordless	80
2eb6e688-bdf5-4b84-bc75-d8a7d54b1fb8	CONFIGURE_TOTP	Configure OTP	68507cda-c551-4ae5-8e9b-474fc4f60060	t	f	CONFIGURE_TOTP	10
7a9f58ca-1652-4fae-b9d5-a1407142924d	UPDATE_PASSWORD	Update Password	68507cda-c551-4ae5-8e9b-474fc4f60060	t	f	UPDATE_PASSWORD	30
d6f4ad99-2bb7-44c2-af56-225a41d23d24	UPDATE_PROFILE	Update Profile	68507cda-c551-4ae5-8e9b-474fc4f60060	t	f	UPDATE_PROFILE	40
faefbfae-3b76-49b0-9a56-e089465886e1	VERIFY_EMAIL	Verify Email	68507cda-c551-4ae5-8e9b-474fc4f60060	t	f	VERIFY_EMAIL	50
5959dbc5-a840-4c89-88ce-abe00026e838	delete_account	Delete Account	68507cda-c551-4ae5-8e9b-474fc4f60060	f	f	delete_account	60
5272b279-5a2c-417d-a255-a07ee231fc62	webauthn-register	Webauthn Register	68507cda-c551-4ae5-8e9b-474fc4f60060	t	f	webauthn-register	70
b2000253-13e3-4e08-a73c-5127466c6ef6	webauthn-register-passwordless	Webauthn Register Passwordless	68507cda-c551-4ae5-8e9b-474fc4f60060	t	f	webauthn-register-passwordless	80
e9c1c850-9941-4afe-ac89-516ab4eab5f8	update_user_locale	Update User Locale	68507cda-c551-4ae5-8e9b-474fc4f60060	t	f	update_user_locale	1000
ff96d512-6441-458d-a7f4-c051a667d71c	TERMS_AND_CONDITIONS	Terms and Conditions	7aa9c96c-04c3-424e-8bf5-94873e7e3275	f	f	TERMS_AND_CONDITIONS	20
948b4c71-f23e-4f1a-a3ee-59a898e1b4dc	TERMS_AND_CONDITIONS	Terms and Conditions	68507cda-c551-4ae5-8e9b-474fc4f60060	f	f	TERMS_AND_CONDITIONS	20
8e218835-8cc6-4460-8151-739a171ca180	delete_credential	Delete Credential	7aa9c96c-04c3-424e-8bf5-94873e7e3275	t	f	delete_credential	100
9efa8aaa-e90c-4ba1-b73f-0ce4dad27e92	delete_credential	Delete Credential	68507cda-c551-4ae5-8e9b-474fc4f60060	t	f	delete_credential	100
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_uris (resource_id, value) FROM stdin;
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
72bc2e99-9371-4f71-a6ef-02d95ae5d000	78d73956-992b-423b-8955-bc8b1cc11b5e
72bc2e99-9371-4f71-a6ef-02d95ae5d000	8670c3d2-03ac-4f16-ac7e-014021575fa9
cec23f3d-0c0d-4446-b19d-777fa17d97c9	d6b0691e-245f-436a-83ed-a46b07bdd08a
cec23f3d-0c0d-4446-b19d-777fa17d97c9	6b1873ae-f97e-40e8-8c16-a85559b784ab
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_attribute (name, value, user_id, id, long_value_hash, long_value_hash_lower_case, long_value) FROM stdin;
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
24337354-76d5-4bac-ad84-9d40a29cfa3b	demo.user@curity.io	demo.user@curity.io	t	t	\N	Demo	User	68507cda-c551-4ae5-8e9b-474fc4f60060	demouser	1667491057353	\N	0
830d4527-c9c9-41c3-8635-0d9af99ab116	\N	7b9c6905-ba9b-4c21-bc41-b4668244e771	f	t	\N	\N	\N	7aa9c96c-04c3-424e-8bf5-94873e7e3275	admin	1668425136630	\N	0
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_group_membership (group_id, user_id) FROM stdin;
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
2d4a63df-b516-4663-8eb3-2bb54255b970	24337354-76d5-4bac-ad84-9d40a29cfa3b
320a3eaf-55a0-4979-962b-437b72ee5965	24337354-76d5-4bac-ad84-9d40a29cfa3b
137b4a16-e5b8-4ac6-9ca3-0121e1f66f4e	830d4527-c9c9-41c3-8635-0d9af99ab116
742fe314-bb0a-4e40-acea-9a4ab20bf605	830d4527-c9c9-41c3-8635-0d9af99ab116
\.


--
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_session (id, auth_method, ip_address, last_session_refresh, login_username, realm_id, remember_me, started, user_id, user_session_state, broker_session_id, broker_user_id) FROM stdin;
\.


--
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_session_note (user_session, name, value) FROM stdin;
\.


--
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.username_login_failure (realm_id, username, failed_login_not_before, last_failure, last_ip_failure, num_failures) FROM stdin;
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.web_origins (client_id, value) FROM stdin;
4ec0fb2f-b504-45f9-9329-cf0a9b44f3b7	+
e450d026-67e5-4609-a564-0d272cbb7826	+
\.


--
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: user_consent uk_jkuwuvd56ontgsuhogm8uewrt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_jkuwuvd56ontgsuhogm8uewrt UNIQUE (client_id, client_storage_provider, external_client_id, user_id);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: fed_user_attr_long_values; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fed_user_attr_long_values ON public.fed_user_attribute USING btree (long_value_hash, name);


--
-- Name: fed_user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fed_user_attr_long_values_lower_case ON public.fed_user_attribute USING btree (long_value_hash_lower_case, name);


--
-- Name: idx_admin_event_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_admin_event_time ON public.admin_event_entity USING btree (realm_id, admin_event_time);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_att_by_name_value; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_att_by_name_value ON public.client_attributes USING btree (name, substr(value, 1, 255));


--
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_client_session_session; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_session_session ON public.client_session USING btree (session_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_att_by_name_value; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_group_att_by_name_value ON public.group_attribute USING btree (name, ((value)::character varying(250)));


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_css_preload; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_css_preload ON public.offline_client_session USING btree (client_id, offline_flag);


--
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- Name: idx_offline_uss_by_usersess; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_by_usersess ON public.offline_user_session USING btree (realm_id, offline_flag, user_session_id);


--
-- Name: idx_offline_uss_createdon; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_createdon ON public.offline_user_session USING btree (created_on);


--
-- Name: idx_offline_uss_preload; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_preload ON public.offline_user_session USING btree (offline_flag, created_on, user_session_id);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON public.offline_client_session USING btree (user_session_id);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_user_service_account; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_service_account ON public.user_entity USING btree (realm_id, service_account_client_link);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: user_attr_long_values; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX user_attr_long_values ON public.user_attribute USING btree (long_value_hash, name);


--
-- Name: user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX user_attr_long_values_lower_case ON public.user_attribute USING btree (long_value_hash_lower_case, name);


--
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES public.user_session(id);


--
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES public.user_session(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- PostgreSQL database dump complete
--

