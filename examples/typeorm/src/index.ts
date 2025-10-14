import 'reflect-metadata';
import { User } from './entity/User';
import {createDatasource } from '@tailor-platform/function-typeorm-tailordb';

export default async () => {
  const ds = createDatasource('provisioning', [User]);
  await ds.initialize();
  const repo = ds.getRepository(User);

  await repo.deleteAll();
  for (let i = 0; i < 3; i++) {
    const newUser = await repo.save(repo.create({
      name: 'test',
      email: `test${i}@example.com`
    }));
    console.log('Inserted user:', newUser.id, newUser.name, newUser.email);
  }
  //
  const rs = await repo.find();
  for (const r of rs) {
    console.log(r.id, r.name, r.email);
  }
  for (const r of rs) {
    const u = await repo.findOneBy({ id: r.id });
    if (!u) continue;
    u.name = 'test-update';
    await repo.save(u);
    console.log('Updated user:', u.id, u.name, u.email);
  }
  await ds.destroy();
}
