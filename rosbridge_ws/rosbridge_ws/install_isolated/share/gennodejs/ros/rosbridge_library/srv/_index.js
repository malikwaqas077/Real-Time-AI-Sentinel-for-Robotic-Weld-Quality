
"use strict";

let TestArrayRequest = require('./TestArrayRequest.js')
let TestEmpty = require('./TestEmpty.js')
let AddTwoInts = require('./AddTwoInts.js')
let TestRequestOnly = require('./TestRequestOnly.js')
let TestMultipleRequestFields = require('./TestMultipleRequestFields.js')
let SendBytes = require('./SendBytes.js')
let TestNestedService = require('./TestNestedService.js')
let TestResponseOnly = require('./TestResponseOnly.js')
let TestRequestAndResponse = require('./TestRequestAndResponse.js')
let TestMultipleResponseFields = require('./TestMultipleResponseFields.js')

module.exports = {
  TestArrayRequest: TestArrayRequest,
  TestEmpty: TestEmpty,
  AddTwoInts: AddTwoInts,
  TestRequestOnly: TestRequestOnly,
  TestMultipleRequestFields: TestMultipleRequestFields,
  SendBytes: SendBytes,
  TestNestedService: TestNestedService,
  TestResponseOnly: TestResponseOnly,
  TestRequestAndResponse: TestRequestAndResponse,
  TestMultipleResponseFields: TestMultipleResponseFields,
};
