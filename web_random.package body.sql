create or replace package body web_random

as

  function r_tld (
    include_country                 boolean         default true
    , include_generic               boolean         default true
  )
  return varchar2

  as

    l_ret_var               varchar2(100);
    l_search_space          varchar2(32000);

  begin

    dbms_application_info.set_action('r_tld');

    l_search_space := core_random_v.g_tld_orig_list;

    if include_country then
      l_search_space := l_search_space || ',' || core_random_v.g_tld_country_list;
    end if;

    if include_generic then
      l_search_space := l_search_space || ',' || core_random_v.g_tld_generic1 || ',' || core_random_v.g_tld_generic2;
    end if;

    l_ret_var := util_random.ru_pickone(l_search_space);

    dbms_application_info.set_action(null);

    return l_ret_var;

    exception
      when others then
        dbms_application_info.set_action(null);
        raise;

  end r_tld;

  function r_domain (
    r_tld                           varchar2        default null
  )
  return varchar2

  as

    l_ret_var               varchar2(100);
    l_tld                   varchar2(50) := r_domain.r_tld;

  begin

    dbms_application_info.set_action('r_domain');

    if l_tld is null then
      l_tld := web_random.r_tld;
    end if;

    l_ret_var := text_random.r_word || l_tld;

    dbms_application_info.set_action(null);

    return l_ret_var;

    exception
      when others then
        dbms_application_info.set_action(null);
        raise;

  end r_domain;

  function r_email (
    use_real_name                   boolean         default false
  )
  return varchar2

  as

    l_ret_var               varchar2(100);

  begin

    dbms_application_info.set_action('r_email');

    if use_real_name then
      l_ret_var := person_random.r_firstname || '@' || r_domain;
    else
      l_ret_var := text_random.r_word || '@' || r_domain;
    end if;

    dbms_application_info.set_action(null);

    return l_ret_var;

    exception
      when others then
        dbms_application_info.set_action(null);
        raise;

  end r_email;

  function r_ipv4
  return varchar2

  as

    l_ret_var               varchar2(100);

  begin

    dbms_application_info.set_action('r_ipv4');

    l_ret_var := core_random.r_natural(1,254) || '.' || core_random.r_natural(1,255) || '.' || core_random.r_natural(1,255) || '.' || core_random.r_natural(1,254);

    dbms_application_info.set_action(null);

    return l_ret_var;

    exception
      when others then
        dbms_application_info.set_action(null);
        raise;

  end r_ipv4;

  function r_url (
    use_secure                      boolean         default false
    , add_query                     boolean         default false
  )
  return varchar2

  as

    l_ret_var               varchar2(250);

  begin

    dbms_application_info.set_action('r_url');

    if use_secure then
      l_ret_var := 'https://www.' || r_domain;
    else
      l_ret_var := 'http://www.' || r_domain;
    end if;

    l_ret_var := l_ret_var || '/' || text_random.r_word || '.html';

    if add_query then
      l_ret_var := l_ret_var || '?' || text_random.r_word(1) || '=' || text_random.r_word(2);
    end if;

    dbms_application_info.set_action(null);

    return l_ret_var;

    exception
      when others then
        dbms_application_info.set_action(null);
        raise;

  end r_url;

  function r_ipv6
  return varchar2

  as

    l_ret_var               varchar2(100);

  begin

    dbms_application_info.set_action('r_ipv6');

    l_ret_var := core_random.r_string(4, core_random_v.g_hex_search_space) || ':' || core_random.r_string(4, core_random_v.g_hex_search_space) || ':' || core_random.r_string(4, core_random_v.g_hex_search_space) || ':' || core_random.r_string(4, core_random_v.g_hex_search_space) || ':' || core_random.r_string(4, core_random_v.g_hex_search_space) || ':' || core_random.r_string(4, core_random_v.g_hex_search_space) || ':' || core_random.r_string(4, core_random_v.g_hex_search_space) || ':' || core_random.r_string(4, core_random_v.g_hex_search_space);

    dbms_application_info.set_action(null);

    return l_ret_var;

    exception
      when others then
        dbms_application_info.set_action(null);
        raise;

  end r_ipv6;

begin

  dbms_application_info.set_client_info('web_random');
  dbms_session.set_identifier('web_random');

end web_random;
/