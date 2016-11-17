@App.controller 'DashboardController', ($scope, $sce, MnoErrorsHandler, MnoeCurrentUser, STAFF_PAGE_AUTH) ->
  'ngInject'
  main = this

  main.errorHandler = MnoErrorsHandler
  main.staffPageAuthorized = STAFF_PAGE_AUTH

  main.trustSrc = (src) ->
    $sce.trustAsResourceUrl(src)

  # Preload data to be reused in the app
  # Marketplace is cached
  # MnoeMarketplace.getApps()

  MnoeCurrentUser.getAdminRole().then(
    # Display the layout
    main.user = MnoeCurrentUser.user
  )

  return
