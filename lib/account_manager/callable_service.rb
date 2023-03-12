module AccountManager
  class CallableService
    def self.call(*args, &b)
      new(*args, &b).call
    end
  end
end
