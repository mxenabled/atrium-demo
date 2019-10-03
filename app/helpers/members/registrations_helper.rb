module Members::RegistrationsHelper
    def str_to_hash(str)
        hash = eval(str)
        p hash
    end
end
