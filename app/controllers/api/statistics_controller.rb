# frozen_string_literal: true
module Api
  class StatisticsController < ApplicationController
    def show
      render json: build_data_object(Statistic.includes(:topic).by_date(date))
    end

    private

    def date
      DateTime.strptime(params[:date], '%Y-%m-%d-%H')
    rescue ArgumentError
      raise InvalidAPIRequest.new('invalid date', 422)
    end
  end
end
