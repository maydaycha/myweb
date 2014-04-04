myapp = angular.module('myApp.translators', []);

myapp.controller('translatorsAccountController', [ '$scope', '$http', 'rails_server', '$route', '$location', function($scope, $http, rails, $route, $location){

  $scope.need_registrate = false;

  console.log(rails.development_server_host);

  $scope.getJobCategory = function() {
    $http.get("/api/translators/getJobCategory").success(function(data) {
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
    var url = "/api/translators/create";
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
    var url = "/api/translators/login";
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
    var url = "/api/translators/isLogin";
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
    var url = "/api/translators/logout";
    $http.get(url, {withCredentials : true} ).success( function(data) {
      console.log(data);
    });
  }


  $scope.getCSRF = function () {
    var url = "/api/translators/csrf_token?callback=JSON_CALLBACK";
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
    })
  }

}]);


myapp.controller('TranslatorsProjectController', [ '$scope', '$http', 'rails_server', '$routeParams', '$location', function($scope, $http, rails, $routeParams, $location) {
  // rails.development_server_host;

  $scope.getProjectList = function() {
    var url = "/api/translators/getJobCategory";
    $http.get(url).success(function(data) {
      console.log(data);
      $scope.jobCategories = data;
    });
    url = "/projects.json";
    $http.get(url).success(function(data) {
      console.log(data);
      $scope.projects = data;
    });
  }

  $scope.getProjectListByTranslator = function() {
    var url = "/api/translators/get_project_by_translator";
    $http.get(url, {withCredentials : true}).success(function(data) {
      console.log(data);
      $scope.projects = data.data;
    });
  }

  $scope.test = function(){
    alert("hi");
  }

  $scope.getProjectAndPublicMessage = function() {
    var url = "/projects/" + $routeParams.projectId + "/edit.json";
    $http.get(url, {withCredentials : true}).success( function(data) {
      console.log(data);
      $scope.project = data;
      $scope.projectName = data.name_chinese;
      $scope.projectDescription = data.description_chinese;
      $scope.projectId = data.outside_id;

      url = "/public_message/edit_via_project/" + $scope.projectId + ".json";
      $http.get(url).success( function(data) {
        console.log(data);
        if ( data.data != null ) {
          if ( data.status == 'success') {
           $scope.originText = data.data.text;
           $scope.publicMessage = data.data.text_chinese;
           console.log($scope.public_message);
         }
       }
     });
    });
  }

  $scope.updateProject = function (id) {
    var url = "/project/update_project_from_angular";
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
      if (data.status == 'success') {
        $scope.updatePublicMessage($scope.projectId);
        $location.path( "/translators/project" );
      }
      else
        alert("save error");
    }).error(function (data, status, headers, config) {
      console.log("error:" + data);
    });
  }

  $scope.updatePublicMessage = function(projectId) {
    var url = "/public_message/update_via_project";
    console.log($scope.publicMessage);
    var param = {
      projectId: projectId,
      text: $scope.publicMessage
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
      if (data.status == 'success') {
        // $location.path( "/translators/project" );
      }
      else
        alert("save error");
    }).error(function (data, status, headers, config) {
      console.log("error:" + data);
    });
  }

  $scope.logout = function() {
    var url = "/api/translators/logout";
    // , {withCredentials : true}
    $http.get(url).success( function(data) {
      console.log(data);
      $location.path("/translators/login")
    });
  }

}]);
