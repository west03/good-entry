class Hosts::HomesController < ApplicationController
   before_action :authenticate_host!
   def top
      @host = current_host
   end
end
