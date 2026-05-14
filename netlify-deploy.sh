export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
export NODE_OPTIONS=--openssl-legacy-provider
node -v
npm -v
#netlify deploy --prod --site your_site_id
netlify deploy --prod --site 927c73b3-b951-4784-a3a0-31dbd63841ce

git add .
git commit -m 'fixes'
git push