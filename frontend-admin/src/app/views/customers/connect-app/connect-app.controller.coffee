@App.controller 'ConnectAppController', ($stateParams, $window, $uibModal, MnoeOrganizations, MnoAppsInstances) ->
  'ngInject'
  vm = this

  vm.mnoAppInstances = MnoAppsInstances

  vm.orgId = $stateParams.orgId
  vm.appTypeTitle = {
    connector: 'Connect these apps',
    cloud: 'No action required'
  }

  vm.isLoading = true
  MnoeOrganizations.get($stateParams.orgId).then(
    (response) ->
      vm.organization = response.data
      vm.typesOfApp = _.map(_.groupBy(vm.organization.active_apps, 'stack'), (value, key) -> key)
  ).finally(-> vm.isLoading = false)

  vm.launchAppInstance = (app) ->
    $window.open("/mnoe/launch/#{app.uid}", '_blank')

  #====================================
  # App Connect modal
  #====================================
  vm.connectAppInstance = (app) ->
    switch app.nid
      when "xero" then modalInfo = {
        template: "app/views/customers/app-connect-modal/app-connect-modal-xero.html",
        controller: 'ConnectXeroModalCtrl'
      }
      when "myob" then modalInfo = {
        template: "app/views/customers/app-connect-modal/app-connect-modal-myob.html",
        controller: 'ConnectMyobModalCtrl'
      }
      else
        vm.launchAppInstance(app)
        return

    $uibModal.open(
      templateUrl: modalInfo.template
      controller: modalInfo.controller
      controllerAs: 'vm'
      resolve:
        app: -> app
    )

  return
