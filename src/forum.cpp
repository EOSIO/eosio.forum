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
        void post(const account_name poster, const std::string& post_uuid, const std::string& content,
                  const account_name reply_to_poster, const std::string& reply_to_post_uuid, const bool certify,
                  const std::string& json_metadata) {
            require_auth(poster);

            eosio_assert(content.size() > 0, "content should be more than 0 characters long.");
            eosio_assert(content.size() < 1024 * 1024 * 10, "content should be less than 10 KB long.");

            eosio_assert(post_uuid.size() > 0, "post_uuid should be longer than 3 characters.");
            eosio_assert(post_uuid.size() < 128, "post_uuid should be shorter than 128 characters.");

            if (reply_to_poster == 0) {
              eosio_assert(reply_to_post_uuid.size() == 0, "If reply_to_poster is not set, reply_to_post_uuid should not be set.");
            } else {
                eosio_assert(is_account(reply_to_poster), "reply_to_poster must be a valid account.");
                eosio_assert(reply_to_post_uuid.size() > 0, "reply_to_post_uuid should be longer than 3 characters.");
                eosio_assert(reply_to_post_uuid.size() < 128, "reply_to_post_uuid should be shorter than 128 characters.");
            }

            if (json_metadata.size() != 0) {
                eosio_assert(json_metadata[0] == '{', "json_metadata must be a JSON object (if specified).");
                eosio_assert(json_metadata.size() < 8192, "json_metadata should be shorter than 8192 bytes.");
            }
        }

        // @abi
        void unpost(const account_name poster, const std::string& post_uuid) {
            require_auth(poster);

            eosio_assert(post_uuid.size() > 0, "Post UUID should be longer than 0 characters.");
            eosio_assert(post_uuid.size() < 128, "Post UUID should be shorter than 128 characters.");
        }

        // @abi
        void propose(const account_name proposer, const name proposal_name, const std::string& title, const std::string& proposal_json) {
            require_auth( proposer );

            eosio_assert(title.size() < 1024, "title should be less than 1024 characters long.");

            if (proposal_json.size() != 0) {
                eosio_assert(proposal_json[0] == '{', "proposal_json must be a JSON object (if specified).");
                eosio_assert(proposal_json.size() < 32768, "proposal_json should be shorter than 32768 bytes.");
            }

            proposals proptable( _self, proposer );
            eosio_assert( proptable.find( proposal_name ) == proptable.end(), "proposal with the same name exists" );

            proptable.emplace( proposer, [&]( auto& prop ) {
                prop.proposal_name = proposal_name;
                prop.title = title;
                prop.proposal_json = proposal_json;
            });
        }

        // @abi
        void unpropose(const account_name proposer, const name proposal_name) {
            require_auth( proposer );
            proposals proptable( _self, proposer );
            auto& prop = proptable.get( proposal_name, "proposal not found" );
            proptable.erase(prop);
        }

        // @abi
        void vote(const account_name voter, const account_name proposer, const name proposal_name, const std::string& proposal_hash, bool vote, const std::string& vote_json) {
            require_auth(voter);

            proposals proptable( _self, proposer );
            auto& prop = proptable.get( proposal_name, "proposal_name does not exist under proposer's scope" );
            eosio_assert( proptable.find( proposal_name ) != proptable.end(), "proposal_name does not exist until proposer's scope");

            // The proposal_hash should be a hash of "title" + the JSON in the `proposal_json` field, appended directly.
            // TODO: check that here.
            eosio_assert(proposal_hash.size() < 128, "proposal_hash should be less than 128 characters long.");

            if (vote_json.size() != 0) {
                eosio_assert(vote_json[0] == '{', "vote_json must be a JSON object (if specified).");
                eosio_assert(vote_json.size() < 4096, "vote_json should be shorter than 4096 bytes.");
            }
        }

    private:

        struct proposal {
            name           proposal_name;
            std::string    title;
            std::string    proposal_json;

            auto primary_key()const { return proposal_name.value; }
        };
        typedef eosio::multi_index<N(proposal),proposal> proposals;
};

EOSIO_ABI( forum, (post)(unpost)(propose)(unpropose)(vote) )
