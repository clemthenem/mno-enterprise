angular.module 'frontendAdmin'
.controller('CommentEditModal', ($scope, $uibModalInstance, comment) ->

  $scope.comment = comment

  # Close the current modal
  $scope.closeModal = ->
    $uibModalInstance.dismiss()

  $scope.submitIteration = ->
    $uibModalInstance.close(comment)

  return
)
