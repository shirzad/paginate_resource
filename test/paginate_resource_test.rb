require File.expand_path('test_helper', File.dirname(__FILE__))

class DummyController < ApplicationController
  include PaginateResource::Controllers::Helpers
  
  def collection
    Post.all
  end
  
  def resource
    Post.first
  end
  
end

class PaginateResourceTest < ActionController::TestCase
  tests DummyController
  
  def test_should_return_next
    post_one = Post.create(title: "t1")
    post_two = Post.create(title: "t2")
    @controller.stubs(:resource).returns(post_one)
    assert_equal post_two, @controller.send(:next_resource)
  end

  def test_should_return_previous
    post_one = Post.create(title: "t1")
    post_two = Post.create(title: "t2")
    @controller.stubs(:resource).returns(post_two)
    assert_equal post_one, @controller.send(:prev_resource)
  end
  
  def test_should_not_return_next
    post_one = Post.create(title: "t1")
    post_two = Post.create(title: "t2")
    @controller.stubs(:resource).returns(post_two)
    assert @controller.send(:next_resource).nil?
  end

  def test_should_not_return_previous
    post_one = Post.create(title: "t1")
    post_two = Post.create(title: "t2")
    @controller.stubs(:resource).returns(post_one)
    assert @controller.send(:prev_resource).nil?
  end
  
  def test_should_rotate_to_one
    post_one = Post.create(title: "t1")
    post_two = Post.create(title: "t2")
    @controller.stubs(:resource).returns(post_two)
    assert_equal post_one, @controller.send(:next_resource, true)
  end
  
  def test_should_return_next_by_title
    post_a = Post.create(title: "a")
    post_c = Post.create(title: "c")
    post_b = Post.create(title: "b")

    @controller.stubs(:collection).returns(Post.all.order("title asc"))
    @controller.stubs(:resource).returns(post_a)

    assert_equal post_b, @controller.send(:next_resource)
  end

  def test_should_return_previous_by_title
    post_a = Post.create(title: "a")
    post_c = Post.create(title: "c")
    post_b = Post.create(title: "b")

    @controller.stubs(:collection).returns(Post.all.order("title asc"))
    @controller.stubs(:resource).returns(post_b)

    assert_equal post_a, @controller.send(:prev_resource)
  end
  
  
end