require 'rubygems'
require 'bundler'

Bundler.setup

require "rails_app/config/environment"
require "rails/test_help"
require 'minitest/autorun'
require 'mocha/setup'


ENV["RAILS_ENV"] = "test"
RAILS_ROOT = "anywhere"

require "active_support"
require "active_model"
require "action_controller"


class ApplicationController < ActionController::Base; end


$:.unshift File.expand_path(File.dirname(__FILE__) + '/../lib')
require 'paginate_resource'