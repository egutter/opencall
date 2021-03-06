angular.module('openCall.services').factory 'UsersService', 
['$q', '$http', ($q, $http) ->

  user_sessions = (id) ->
    deferred = $q.defer()

    $http.get("/users/session_proposals")
    .success((data, status) ->
      deferred.resolve data.sessions
    ).error (data, status) ->
      deferred.reject()

    deferred.promise

  user_voted_sessions = (id) ->
    deferred = $q.defer()

    $http.get("/users/voted_session_proposals")
    .success((data, status) ->
      deferred.resolve data.sessions
    ).error (data, status) ->
      deferred.reject()

    deferred.promise

  user_faved_sessions = (id) ->
    deferred = $q.defer()

    $http.get("/users/faved_session_proposals")
    .success((data, status) ->
      deferred.resolve data.sessions
    ).error (data, status) ->
      deferred.reject()

    deferred.promise

  user_reviews = () ->
    deferred = $q.defer()

    $http.get("/users/reviews")
    .success((data, status) ->
      deferred.resolve data.reviews
    ).error (data, status, header, config) ->
      switch status
        when 403 then message = "access_denied"
        else message = "generic"

      deferred.reject message

    deferred.promise

  user_review_for = (session_proposal_id) ->
    deferred = $q.defer()

    $http.get("/users/review/#{session_proposal_id}")
    .success((data, status) ->
      deferred.resolve data
    ).error (data, status, header, config) ->
      switch status
        when 400 then message = "session_not_found"
        when 403 then message = "access_denied"
        else message = "generic"

      deferred.reject message

    deferred.promise

  user_session_voted_ids = () ->
    deferred = $q.defer()

    $http.get("/users/session_voted_ids")
    .success((data, status) ->
      deferred.resolve data
    ).error (data, status) ->
      deferred.reject()

    deferred.promise

  user_session_faved_ids = () ->
    deferred = $q.defer()

    $http.get("/users/session_faved_ids")
    .success((data, status) ->
      deferred.resolve data
    ).error (data, status) ->
      deferred.reject()

    deferred.promise

  toggle_vote_session = (id, vote) ->
    deferred = $q.defer()

    $http.post("/users/vote_session",
      id: id
      vote: vote
    ).success((data, status) ->
      deferred.resolve data
    ).error (data, status) ->
      deferred.reject()

    deferred.promise

  toggle_fav_session = (id) ->
    deferred = $q.defer()

    $http.post("/users/fav_session",
      id: id
    ).success((data, status) ->
      deferred.resolve data
    ).error (data, status) ->
      deferred.reject()

    deferred.promise

  user_sessions: user_sessions
  user_voted_sessions: user_voted_sessions
  user_faved_sessions: user_faved_sessions
  user_reviews: user_reviews
  user_review_for: user_review_for
  user_session_voted_ids: user_session_voted_ids
  user_session_faved_ids: user_session_faved_ids
  toggle_vote_session: toggle_vote_session
  toggle_fav_session: toggle_fav_session
]