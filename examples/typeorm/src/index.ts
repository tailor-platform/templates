import 'reflect-metadata';
import { User } from './entity/User';
import { createDatasource } from '@tailor-platform/function-typeorm-tailordb';

export default async () => {
  const ds = createDatasource({
    namespace: 'provisioning',
    entities: [User],
    logging: true
  });
  await ds.initialize();
  const repo = ds.getRepository(User);
  await repo.deleteAll();

  const cnt1 = await repo.count({});
  console.log(`count=${cnt1}`)

  await ds.transaction(async (em) => {
    const repo = em.getRepository(User);
    for (let i = 0; i < 3; i++) {
      const newUser = await repo.save(repo.create({
        name: 'test',
        email: `test${i}@example.com`
      }));
      console.log('Inserted user:', newUser.id, newUser.name, newUser.email);
    }
  });

  console.log(`count=${await repo.count({})}`)
  //
  const rs = await repo.find();
  for (const r of rs) {
    console.log(`Confirm: ${r.id}, ${r.name}, ${r.email}`);
  }

  await ds.transaction(async (em) => {
    const repo = em.getRepository(User);
    for (let i = 0; i < 3; i++) {
      const u = await repo.findOneBy({id: rs[i].id});
      if (!u) continue;
      u.name = `test-update${i}`;
      await repo.save(u);
      console.log('Updated user:', u.id, u.name, u.email);
    }
  });


  const rs1 = await repo.find();
  for (const r of rs1) {
    console.log(`Confirm2: ${r.id}, ${r.name}, ${r.email}`);
  }

  await ds.destroy();
}
