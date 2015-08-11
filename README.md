# user_bill

gem that one needs to install to run the code

```ruby
gem install active_model ## for validations
gem install rspec ## for testing
```

- program file location: `services/net_payable_service.rb`
- objects location: `classes/*`
- spec location: `spec/net_payable_spec.rb`

Run tests:
```ruby
rspec spec/net_payable_spec.rb ## assuming you are in the root of the project.
```

In order to add more discount types:

1. open `net_payable_service.rb`, add another set of constant, which is a proc, where you will add the discounted price logic.
2. add a condition in the `discounted_price` function which will determine which proc will be used when
