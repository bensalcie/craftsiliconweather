// ignore_for_file: constant_identifier_names, dangling_library_doc_comments

/// PAGE ROUTES
/// [home_page_route]
/// [search_page_route]

const home_page_route = '/home-page';

const search_page_route = '/search-page';
const search_page_index = 'search-page';

const no_internet_page_route = 'no-internet';

const home_page_route_to_no_internet_page_route =
    '$home_page_route/$no_internet_page_route';

const search_page_route_to_no_internet_page_route =
    '$search_page_route/$no_internet_page_route';

const home_page_route_to_settings_page = '$home_page_route/$search_page_index';

const home_page_to_search = '$home_page_route/$search_page_route';

const privacy_page_index = 'privacy';
const about_page_index = 'about';
