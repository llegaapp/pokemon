class ApiEndpoints {
  static String qmLogin(String employeeId, password, deviceId) {
    return '''
        mutation {
          auth_login(
            idEmployee: "$employeeId", 
            password: "$password", 
            pushTkn: "",
            ip_address: "",
            id_device: "$deviceId",
            latitude: "",
            auth_status: ""
          ) {
            responseCode {
              code,
              description,
              level,
              message
            },
            data {
              token
            }
          }
        }          
        ''';
  }

  static String appClosingDayBySupervisor() {
    return '''
        mutation {
          app_closing_day_by_supervisor {
            responseCode {
              code,
              level,
              message,
              description
            },
            data {
              attendance_list {
                id_anaquelero,
                name_anaquelero,
                route_show,
                id_client_route,
                attendance,
                search_field,
                time_start
              },
              absence_list {
                id_anaquelero,
                name_anaquelero,
                route_show,
                id_client_route,
                attendance,
                search_field,
                time_start
              },
              all {
                id_anaquelero,
                name_anaquelero,
                route_show,
                id_client_route,
                attendance,
                search_field,
                time_start
              }
            }
          }
        }        
        ''';
  }

  static String qmHomeInfo() {
    return '''
          {
            app_get_home_info {
              responseCode {
                code,
                level,
                description,
                message
              },
              data {
                id_client_route,
                client_id,
                client_name,
                status_id_schedule,
                status_name_schedule,
                status_color_schedule,
                time_start,
                time_end,
                time_show,
                hours,
                hours_show,
                today_show
              }
            }
          }
        ''';
  }

  static String qmClientById(String idClientRoute) {
    return '''
        {
          app_get_schedule_client_route_by_id(
            id_client_route: $idClientRoute
          ) {
            responseCode {
              code,
              description,
              level,
              message
            },
            data {
              id_client_route,
              date,
              time_show,
              events {
                id_registered_event,
                id_client_route,
                is_chekin,
                is_checkout,
                is_event,
                x_coordinate,
                y_coordinate,
                created,
                finished,
                event_type {
                  id_catalog_event,
                  name,
                  description
                }
              },
              client {
                id_client,
                id_chain,
                description,
                lowDate,
                client_address,
                x_coordinate,
                y_coordinate,
                business_name,
                full_address,
                branch_office,
                is_NOSIO,
                type_client {
                  id,
                  name,
                  description
                }
              }
            }
          }
        }
        ''';
  }

  static String qmAppCheckin(String idClientRoute, lat, long, device_date,
      device_gtm, is_online, b64_evidence_photo) {
    return '''
      mutation {
        app_checking(
          id_client_route: $idClientRoute, 
          x_coordinate: "$long", 
          y_coordinate: "$lat",
          device_date: "$device_date",
          device_gtm: "$device_gtm"
        ) {
          responseCode {
            code,
            description,
            level,
            message
          }
        }
      }
       ''';
  }

  static String qmAppCheckout(String idClientRoute, lat, long, comment,
      deviceDate, deviceGTM, is_online, b64_evidence_photo) {
    return '''
      mutation {
        app_checkout(
          id_client_route: $idClientRoute, 
          x_coordinate: "$long", 
          y_coordinate: "$lat",
          description: "$comment",
          device_date: "$deviceDate",
          device_gtm: "$deviceGTM"
        ) {
          responseCode {
            code,
            description,
            level,
            message
          }
        }
      }
       ''';
  }

  static String appManageClientOutFrequencyBySupervisor(
      String idClient, idCellar, idAnaquelero, startTime, endTime) {
    return '''
      mutation {
          app_manage_client_out_frequency_by_supervisor(
            id_client: $idClient,
            id_cellar: $idCellar,
            id_anaquelero: $idAnaquelero,
            start_time: "$startTime",
            end_time: "$endTime"
          ) {
            responseCode {
              code,
              level,
              message,
              description
            }
          }
        }
       ''';
  }

  static String qmEventList() {
    return '''
          {
            get_cat_events_list {
              responseCode {
                code,
                message,
                level,
                description
              },
              data {
                id_catalog_event,
                name,
                description,
                times
              }
            }
          }
        ''';
  }

  static String qmAppStartEvent(String idClientRoute, idCatalogEvent, lat, long,
      device_date, device_gtm) {
    String _sql = '''
        mutation {
          app_start_event(
            id_client_route: $idClientRoute,
            id_catalog_event: $idCatalogEvent,
            x_coordinate: "$long",
            y_coordinate: "$lat",
            device_date: "$device_date",
            device_gtm: "$device_gtm"
          ) {
            responseCode {
              code,
              description,
              level,
              message
            },
            data {
                id_registered_event
            }
          }
        }
       ''';
    return _sql;
  }

  static String qmAppEndEvent(
      String idRegisteredEvent, device_date, device_gtm) {
    String _sql = '''
        mutation {
          app_end_event(
            id_registered_event: $idRegisteredEvent,
            device_date: "$device_date",
            device_gtm: "$device_gtm"
          ) {
            responseCode {
              code,
              description,
              level,
              message
            }
          }
        }
       ''';
    return _sql;
  }

  static String qmLogout() {
    return '''
        mutation {
          auth_logout {
            responseCode {
              code,
              description,
              level,
              message
            }
          }
        }
       ''';
  }

  static String qmGetAppHomeListCurrentScheduleClientsBySupervisor(
      int skip, int limit) {
    return '''
          {
            get_app_home_list_current_schedule_clients_by_supervisor (
              skip: $skip,
              limit: $limit
            ) {
              responseCode {
                code,
                description,
                level,
                message
              },
              today_show,
              total_records,
              data {
                id_route,
                name_route,
                route_show,
                id_supervisor_base_team,
                name_supervisor_base_team,
                id_anaquelero_base_team,
                name_anaquelero_base_team,
                week_days_base_team,
                id_supervisor_backup_team,
                name_supervisor_backup_team,
                id_anaquelero_backup_team,
                name_anaquelero_backup_team,
                week_days_backup_team,
                id_team_type,
                team_type,
                diary {
                  id_client,
                  name_client,
                  id_cellar,
                  name_cellar,
                  start_time,
                  end_time,
                  hours,
                  id_status,
                  name_status,
                  color_status,
                  id_client_route
                }
              }
            }
          }  
           ''';
  }

  static String getAppAllClientsListByRouteSupervisor(String idRoute) {
    String _sql = '''
          {
            get_app_all_clients_list_by_route_supervisor(
              id_route: "$idRoute"
            ) {
              responseCode {
                code,
                description,
                level,
                message
              },
              data {
                idClient: id_client,
                nameClient: name_client,
                idCellar: id_cellar,
                nameCellar: name_cellar,
                idClientRoute: id_client_route,
                idRoute: id_route,
                nameRoute: name_route,
                idStatus: id_status,
                nameStatus: name_status,
                clientShow: client_show,
                cellarShow: cellar_show,
                clientAddress: client_address,
                anaquelero {
                  anaqueleroIdRoute: id_route,
                  anaqueleroIdAnaquelero: id_anaquelero,
                  anaqueleroAnaquelero: anaquelero,
                  anaqueleroTypeAssign: type_assign
                }
              }
            }
          }
           ''';
    print(_sql);
    return _sql;
  }

  static String getAppCatRouteBySupervisor() {
    return '''
          {
            get_app_cat_routes_by_supervisor {
              responseCode {
                code,
                description,
                level,
                message
              },
              data {
                idRoute: id,
                nameRoute: name
              }
            }
          }
           ''';
  }

  static String getAppCatRoutesBySupervisor(bool isToday) {
    return '''
          {
            get_app_cat_routes_by_supervisor(
              is_today: $isToday
            ) {
              responseCode {
                code,
                description,
                level,
                message
              },
              data {
                idRoute: id,
                nameRoute: name
              }
            }
          } 
           ''';
  }

  static String appGetTeamListBySupervisor(bool isToday) {
    return '''
          {
            app_get_team_list_by_supervisor(
              is_today: $isToday,
              is_attendance: false,
              id_route: ""
              find: ""
            ) {
              responseCode {
                code,
                level,
                message,
                description
              },
              data {
                is_day_closed,
                attendance_count,
                absence_count,
                attendance_list {
                  id_anaquelero,
                  name_anaquelero,
                  route_show,
                  id_client_route,
                  attendance,
                  search_field,
                  time_start,
                  active_from,
                  profile,
                  show_attendance,
                  details {
                    id_route,
                    id_client,
                    id_cellar,
                    id_client_route,
                    client_name,
                    time,
                    hours,
                    status,
                    status_id,
                    status_desc,
                    status_color
                  }
                },
                absence_list {
                  id_anaquelero,
                  name_anaquelero,
                  route_show,
                  id_client_route,
                  attendance,
                  search_field,
                  time_start,
                  active_from,
                  profile,
                  show_attendance,
                  details {
                    id_route,
                    id_client,
                    id_cellar,
                    id_client_route,
                    client_name,
                    time,
                    hours,
                    status,
                    status_id,
                    status_desc,
                    status_color
                  }
                },
                all {
                  id_anaquelero,
                  name_anaquelero,
                  route_show,
                  id_client_route,
                  attendance,
                  search_field,
                  time_start,
                  active_from,
                  profile,
                  show_attendance,
                  details {
                    id_route,
                    id_client,
                    id_cellar,
                    id_client_route,
                    client_name,
                    time,
                    hours,
                    status,
                    status_id,
                    status_desc,
                    status_color
                  }
                }
              }
            }
          }
           ''';
  }

  static String getAppAllClientsListByRouteSupervisorToday(String idRoute) {
    return '''
          {
            get_app_all_clients_list_by_route_supervisor_today(
              id_route: "$idRoute"
            ) {
              responseCode {
                code,
                description,
                level,
                message
              },
              data {              
                idClient: id_client,
                nameClient: name_client,
                idCellar: id_cellar,
                nameCellar: name_cellar,
                idRoute: id_route,
                idClientRoute: id_client_route,
                nameRoute: name_route,
                idStatus: id_status,
                nameStatus: name_status,
                clientShow: client_show,
                cellarShow: cellar_show,
                clientAddress: client_address,
                anaquelero {
                  anaqueleroIdRoute: id_route,
                  anaqueleroIdAnaquelero: id_anaquelero,
                  anaqueleroAnaquelero: anaquelero,
                  anaqueleroTypeAssign: type_assign
                }
              }
            }
          } 
           ''';
  }

  static String appGetAnaquelerosToManageClient() {
    return '''
         {
            app_get_anaqueleros_to_manage_client {
              responseCode {
                code,
                description,
                level,
                message
              },
              data {
                id,
                name
              }
            }
          } 
           ''';
  }

  static String qmClientDetailsBySupervisor(
      String idRoute, idClient, idCellar, idClientRoute) {
    String query = '''
          {
            get_app_client_details_by_supervisor(
              id_route: "$idRoute",
              id_client: $idClient,
              id_cellar: $idCellar,
              id_client_route: $idClientRoute
            ) {
              responseCode {
                code,
                level,
                description,
                message
              },
              data {
                id_client_route,
                client_id,
                client_name,
                cellar_id,
                cellar_name,
                client_show,
                cellar_show,
                status_id,
                status_name,
                status_color,
                start_time,
                end_time,
                time_show,
                diff_time_show,
                activity_hours_show,
                diff_activity_hours_show,
                events {
                  checkin {
                    time_start,
                    diff,
                    distance,
                    color,
                    device_date,
                    device_gtm
                  },
                  comida {
                    time_start,
                    time_end,
                    created,
                    current,
                    device_date,
                    device_gtm,
                    end_device_date,
                    end_device_gtm,
                    current_device_date,
                    current_device_gtm
                  },
                  checkout {
                    time_start,
                    diff,
                    distance,
                    color,
                    device_date,
                    device_gtm
                  }
                },
                client_address,
                anaquelero {
                  route_show,
                  anaquelero,
                  id_anaquelero,
                  type_assign,
                  id_team_type,
                  team_type
                }
              }
            }
          }
        ''';
    return query;
  }

  static String qmClientDetailsOtherRoutesBySupervisor(
      String idRoute, idClient, idCellar) {
    return '''
          {
            get_app_client_details_other_routes_by_supervisor(
              id_route: "$idRoute",
              id_client: $idClient,
              id_cellar: $idCellar
            ) {
              responseCode {
                code,
                description,
                level,
                message
              },
              data {
                id_route,
                description,
                route_show,
                details {
                  anaquelero
                }
              }
            }
          }
        ''';
  }

  static String qmGetAnaquelerosToManageClient(String id_client_route) {
    String query = '''
        {
          app_get_anaqueleros_to_manage_client(
            id_client_route: $id_client_route
          ) {
            responseCode {
              code,
              description,
              level,
              message
            },
            data {
              id,
              name
            }
          }
        }
        ''';
    return query;
  }

  static String qmMarkAssistanceBySupervisor(String idClientRoute, idAnaquelero,
      checkinTime, checkoutTime, deviceGTM) {
    String query = '''
        mutation {
          app_mark_assistance_by_supervisor(
            id_client_route: $idClientRoute,
            id_anaquelero: $idAnaquelero,
            checking_time: "$checkinTime",
            comida_start_time: "",
            comida_end_time: "",
            checkout_time: "$checkoutTime",
            b64_evidence_photo: "",
            device_gtm: "$deviceGTM"
          ) {
            responseCode {
              code,
              level,
              description,
              message
            }
          }
        }
        ''';
    return query;
  }

  static String qmReassignReplacementAnaquelero(
      String idClientRoute, idAnaquelero, startTime, endTime) {
    String query = '''
        mutation {
          app_reassign_replacement_anaquelero(
            id_client_route: $idClientRoute,
            id_replacement_anaquelero: $idAnaquelero,
            replacement_start_time: "$startTime",
            replacement_end_time: "$endTime"
          ) {
            responseCode {
              code,
              level,
              description,
              message
            }
          }
        }
        ''';
    return query;
  }

  static String qmGetProfileInfoUser() {
    String query = '''
              {
                app_get_profile_info_user {
                  responseCode {
                    code,
                    description,
                    message,
                    level
                  },
                  data {
                    user_id,
                    user_name,
                    profile,
                    manager_type,
                    manager_name,
                    active_since
                  }
                }
              }
        ''';
    return query;
  }

  static String appGetCountClientsStatesTodaySySupervisor() {
    String query = '''
              {
                app_get_count_clients_states_today_by_supervisor {
                  responseCode {
                    code,
                    description,
                    message,
                    level
                  },
                  data {
                    all,
                    finished,
                    inProgress:in_progress,
                    pending
                  }
                }
              }
        ''';
    return query;
  }

  static String appRegisterUserDummy(String name, email, bornDate, password) {
    String sql = '''
            mutation {
              app_register_user_dummy(
                user: {
                  name: "$name",
                  email: "$email",
                  born_date: "$bornDate",
                  password: "$password"
                }
              ) {
                responseCode {
                  code,
                  message,
                  level,
                  description
                }
              }
            }
           ''';
    return sql;
  }
}
