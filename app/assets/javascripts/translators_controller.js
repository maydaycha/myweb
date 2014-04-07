myapp = angular.module('myApp.translators', []);

myapp.controller('translatorsAccountController', [ '$scope', '$http', 'rails_server', '$route', '$location', function($scope, $http, rails, $route, $location){

  $scope.need_registrate = false;

  $scope.server_url = rails.development_server_host;
  console.log($scope.server_url);

  $scope.getJobCategory = function() {
    $http.get($scope.server_url+"/api/translators/getJobCategory").success(function(data) {
      console.log(data);
      $scope.jobCategories = data;
    });
  }

  $scope.goto_registrate = function() {
    $scope.need_registrate = true;
    $scope.getJobCategory();
  }

  $scope.registrate = function() {
    var param = {
      "account" : $scope.account,
      "password" : $scope.password,
      "name" : $scope.name,
      "category" : $scope.category.id
    };
    var url = $scope.server_url + "/api/translators/create";
    $http.post(url, param).success( function (data) {
      console.log(data)
      if (data.status == 'success') {
        $route.reload();
      } else {
        alert(data.reason);
      }
    });
  }

  $scope.login = function() {
    var url = $scope.server_url + "/api/translators/login"
    console.log(getCookie("csrftoken"));
    if (typeof getCookie("csrftoken") == 'undefined') {
      $scope.getCSRF();
    } else {
      var param = {
        "account" : $scope.account,
        "password" : $scope.password
      };
      $http({
        method: 'POST',
        url: url,
        data: $.param(param),
        withCredentials: true,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'X-CSRF-TOKEN': getCookie("csrftoken")
        }}).
      success(function (data, status, headers, config) {
        console.log(data);
        if(data.status == 'success')
          $location.path( "/translators/project" );
        else
          alert(data.reason);
      }).error(function (data, status, headers, config) {
        console.log("error:" + data);
      });
    }
  }

  $scope.isLogin = function() {
    var url = $scope.server_url + "/api/translators/isLogin";
    $http({
      method: 'POST',
      url: url,
      withCredentials: true,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'X-CSRF-TOKEN': getCookie("csrftoken")
      }}).
    success(function (data, status, headers, config) {
      console.log(data);
    }).error(function (data, status, headers, config) {
      console.log("error:" + data);
    });

  }
  $scope.logout = function() {
    var url = $scope.server_url + "/api/translators/logout";
    $http.get(url, {withCredentials : true} ).success( function(data) {
      console.log(data);
    });
  }


  $scope.getCSRF = function () {
    var url = $scope.server_url + "/api/translators/csrf_token?callback=JSON_CALLBACK";
    $http.jsonp(url).success(function(data) {
      console.log(data);
      $scope.csrf = data.csrfmiddlewaretoken;
      document.cookie = "csrftoken=" + $scope.csrf;
      console.log(document.cookie);
      $scope.login();
    });
  }

  $scope.test = function() {
    var url = "/api/translators/getJobCategory";
    $http.get(url).success(function(data) {
      console.log(data);
    });
  }

}]);


myapp.controller('TranslatorsProjectController', [ '$scope', '$http', 'rails_server', '$routeParams', '$location', function($scope, $http, rails, $routeParams, $location) {
  $scope.serverUrl = rails.development_server_host;

  $scope.getProjectList = function() {
    $http.get($scope.serverUrl+"/api/translators/getJobCategory").success(function(data) {
      console.log(data);
      $scope.jobCategories = data;
    });
    var url = $scope.serverUrl + "/projects.json"
    $http.get(url).success(function(data) {
      console.log(data);
      $scope.projects = data;
    });
  }

  $scope.getProjectListByTranslator = function() {
    var url = $scope.serverUrl + "/api/translators/get_project_by_translator";
    $http.get(url, {withCredentials : true}).success(function(data) {
      console.log(data);
      $scope.projects = data.data;
    });
  }

  $scope.editProject = function (id) {
    var url = $scope.serverUrl + "/projects/" + id + "/edit.json";
    $http.get(url, {withCredentials : true}).success( function(data) {
      console.log(data);
      $scope.project = data;
      $scope.projectName = data.name_chinese;
      $scope.projectDescription = data.description_chinese;
    });
  }

  $scope.updateProject = function (id) {
    var url = $scope.serverUrl + "/project/update_project_from_angular";
    var param = {
      projectId: id,
      projectName: $scope.projectName,
      projectDescription: $scope.projectDescription
    };

    $http({
      method: 'post',
      url: url,
      data: $.param(param),
      withCredentials: true,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'X-CSRF-TOKEN': getCookie("csrftoken")
      }}).
    success(function (data, status, headers, config) {
      console.log(data);
      if (data.status == 'success')
        $location.path( "/translators/project" );
      else
        alert("save error");
    }).error(function (data, status, headers, config) {
      console.log("error:" + data);
    });

  }

  $scope.logout = function() {
    var url = $scope.serverUrl + "/api/translators/logout";
    $http.get(url, {withCredentials : true}).success( function(data) {
      console.log(data);
      $location.path("/translators/login")
    });
  }

  if ($routeParams.projectId) {
    $scope.editProject($routeParams.projectId);
  } else {
   $scope.getProjectListByTranslator();
 }


}]);
