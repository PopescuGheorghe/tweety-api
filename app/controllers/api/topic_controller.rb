# frozen_string_literal: true
module Api
  class TopicController < ApplicationController
    def show
      render json: build_data_object(Topic.find(params[:id]))
    end

    def index
      render json: build_data_object(Topic.all)
    end

    def create
      topic = Topic.new(topic_params)
      if topic.save
        render json: build_data_object(topic), status: 201
      else
        render json: build_error_object(topic), status: 422
      end
    end

    private

    def topic_params
      params.require(:topic).permit(:name)
    end
  end
end
