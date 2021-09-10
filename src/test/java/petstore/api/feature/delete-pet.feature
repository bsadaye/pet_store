Feature: Add new pet to the store

  Background:
    * url petStoreBaseUrl: 'http://localhost:8080/api/v3/pet'

  # Acceptance Criteria 11
  Scenario Outline: Delete pet by id
    Given path '/<id>'
    When method DELETE
    Then status <statusCode>

    Examples:
      | id  | statusCode |
      | 2   | 200        |
      | abc | 400        |