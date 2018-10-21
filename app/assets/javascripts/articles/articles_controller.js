
angular.module('Articles').controller('ArticlesController', ['$scope', '$http', '$timeout',
function($scope, $http, $timeout) {
  setAngularCSRFToken($http);

  // *********************************Private functions***********************************************

  // *********************************Public functions***********************************************

  $scope.fetchArticles = function(){

    $http({
      method: "POST",
      url: "/fetch_articles",
      data: $scope.state
    }).success(function(response){
      $scope.success_message = response.message;
    }).error(function(){
      $scope.error_message = "Something went wrong with the server";
    });
  };

  // *********************************Initialization Code***********************************************
  $scope.state = {
    tag: null
  };

}]);
