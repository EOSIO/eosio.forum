#include <eosiolib/eosio.hpp>

#include <string>

using eosio::name;

class forum : public eosio::contract {
    public:
        forum(account_name self)
        :eosio::contract(self)
        {}
        /// @param certify - under penalty of perjury the content of this post is true.
        // @abi
        void post(const account_name account, const uint32_t post_num, const std::string& title, const std::string& content,
                  const account_name reply_to_account, const uint32_t reply_to_post_num, const bool certify) {
            require_auth(account);
            eosio_assert(title.size() < 128, "Title should be less than 128 characters long.");

            eosio_assert(content.size() > 0, "Content should be more than 0 characters long.");
            eosio_assert(content.size() < 1024 * 1024 * 10, "Content should be less than 10 KB long.");

            eosio_assert(post_num > 0, "Post number should be greater than 0 to post.");
            if (reply_to_account == 0) {
                eosio_assert(reply_to_post_num == 0, "If reply_to_account is not set, reply_to_post_num should not be set.");
            } else {
                eosio_assert(is_account(reply_to_account), "reply_to_account must be a valid account.");
                eosio_assert(title.size() == 0, "If the post is a reply, there should not be a title.");
            }
        };
        
        // @abi
        void remove(const account_name account, const uint32_t post_num) {
            require_auth(account);
            eosio_assert(post_num > 0, "Post number should be greater than 0 to remove.");
        }
};

EOSIO_ABI( forum, (post)(remove) )
