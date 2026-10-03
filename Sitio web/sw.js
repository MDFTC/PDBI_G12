// Sube el número de V cada vez que actualices los archivos
const V='mc-v1';
const CDN='https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js';
const FILES=['./','index.html','manifest.json','icon-192.png','icon-512.png'];
self.addEventListener('install',e=>{e.waitUntil((async()=>{
  const c=await caches.open(V);await c.addAll(FILES);
  try{await c.put(CDN,await fetch(new Request(CDN,{mode:'no-cors'})))}catch(_){}
  self.skipWaiting();})())});
self.addEventListener('activate',e=>{e.waitUntil((async()=>{
  for(const k of await caches.keys())if(k!==V)await caches.delete(k);
  await self.clients.claim();})())});
self.addEventListener('fetch',e=>{
  if(e.request.method!=='GET')return;
  e.respondWith(caches.match(e.request,{ignoreSearch:true}).then(c=>{
    const n=fetch(e.request).then(r=>{
      if(r&&(r.ok||r.type==='opaque')){const k=r.clone();caches.open(V).then(x=>x.put(e.request,k))}
      return r}).catch(()=>c);
    return c||n;}))});
