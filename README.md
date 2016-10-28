### Targeter module

Ruby API module built for a code challenge. It consists of a single endpoint which will receive POST calls with attack modes and radar with friends and foes on them. The endpoint returns a single radar point chosen from the entries array, filtered according to the attack modes.

See docs folder for more specs

* Ruby version: `2.3.1`
* Install dependencies: `bundle install`
* Run: `rackup -p 8888`

### Run tests attack

Run the module as specified before, then...

```
cd test_attack
chmod +x test_attack.sh
./test_attack.sh
```
