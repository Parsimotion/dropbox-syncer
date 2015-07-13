app.factory "Producteca", ($resource) ->
  envResource = $resource "/api/settings/env", { }

  envResource.get().$promise.then (env) =>
    (token) ->
      setAuthorizationHeader = (data, headersGetter) -> headersGetter().Authorization = "Bearer #{token}"
      toNames = (data) -> _.map (JSON.parse data), "name"
      endpoint = env.apiUrl

      $resource endpoint, {},
        user:
          method: "GET"
          url: "#{endpoint}/users/me"
          transformRequest: setAuthorizationHeader
<<<<<<< HEAD

        priceLists:
          method: "GET"
          url: "#{endpoint}/pricelists"
          transformRequest: setAuthorizationHeader
          transformResponse: toNames
          isArray: true

        warehouses:
          method: "GET"
          url: "#{endpoint}/warehouses"
          transformRequest: setAuthorizationHeader
          transformResponse: toNames
          isArray: true
=======
>>>>>>> c6fd6501923fe3458eb4d26c2f43af59c6ca090b
