import { createClient } from '@supabase/supabase-js';
import { readFile } from 'node:fs/promises';
import { basename, resolve } from 'node:path';

const url = process.env.SUPABASE_URL;
const serviceKey = process.env.SUPABASE_SERVICE_ROLE_KEY;
if (!url || !serviceKey) {
  console.error('Defina SUPABASE_URL e SUPABASE_SERVICE_ROLE_KEY somente nesta execução local. Não use service_role no navegador, .env.local ou Vercel.');
  process.exit(1);
}
const supabase = createClient(url, serviceKey, { auth: { persistSession: false, autoRefreshToken: false } });
const { data: images, error } = await supabase.from('images').select('id,culture_id,page_id,url,storage_path').like('url', '/images/%');
if (error) throw error;
if (!images?.length) {
  console.log('Nenhuma imagem local pendente: as imagens já foram sincronizadas ou as migrações ainda não foram executadas.');
  process.exit(0);
}
let copied = 0;
for (const image of images) {
  const relative = image.url.replace(/^\//, '');
  const filePath = resolve(process.cwd(), 'public', relative);
  const bytes = await readFile(filePath);
  const key = image.storage_path || `seed/${basename(relative)}`;
  const { error: uploadError } = await supabase.storage.from('bestiario-images').upload(key, bytes, {
    upsert: true,
    contentType: 'image/jpeg',
    cacheControl: '31536000',
  });
  if (uploadError) throw uploadError;
  const publicUrl = supabase.storage.from('bestiario-images').getPublicUrl(key).data.publicUrl;
  const { error: updateError } = await supabase.from('images').update({ url: publicUrl, storage_path: key }).eq('id', image.id);
  if (updateError) throw updateError;
  if (!image.page_id) {
    const { error: coverError } = await supabase.from('cultures').update({ cover_image_url: publicUrl }).eq('id', image.culture_id);
    if (coverError) throw coverError;
  }
  copied++;
  console.log(`Sincronizada ${basename(relative)} → ${key}`);
}
console.log(`${copied} registro(s) de imagem apontam agora ao Supabase Storage.`);
