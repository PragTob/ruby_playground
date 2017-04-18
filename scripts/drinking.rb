# yes this code is not meant to be executed

def serve_alcoholic_drink(customer, requested_drink)
  if allowed_to_drink_alcohol?(customer)
    serve_drink requested_drink, customer
  else
    propose_non_alcoholic_drink
  end
end

# more public methods

private

def allowed_to_drink_alcohol?(customer)
  # ...
end

def serve_drink(requested_drink, customer)
  # ...
end

def propose_non_alcoholic_drink
  # ....
end
