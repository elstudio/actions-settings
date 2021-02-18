jest.mock('uuid');
jest.mock('@actions/core');
jest.mock('probot');

const uuid = require('uuid');

const core = require('@actions/core');

const { Probot } = require('probot');

const adapt = require('probot-actions-adapter');

describe('action-settings', () => {
  let probot;

  beforeEach(() => {
    // Mock uuid
    uuid.v4 = jest.fn(() => 'uuid-v4');

    // Mock probot
    probot = {
      setup: jest.fn(),
      receive: jest.fn(async () => true)
    };

    Probot.mockImplementation(() => {
      return probot;
    });
  });

  test('that we can adapt a single handler', async () => {
    const handler = () => {};
    await adapt(handler);

    expect(Probot).toHaveBeenCalledWith({ githubToken: 'GITHUB_TOKEN' });
    expect(probot.setup).toHaveBeenCalledWith([handler]);
    expect(probot.receive).toHaveBeenCalledWith({ id: 'uuid-v4', name: 'push', payload: { commits: [] } });
  });

  test('that we can adapt many handlers', async () => {
    const handlers = [() => {}, () => {}];
    await adapt(...handlers);

    expect(Probot).toHaveBeenCalledWith({ githubToken: 'GITHUB_TOKEN' });
    expect(probot.setup).toHaveBeenCalledWith(handlers);
    expect(probot.receive).toHaveBeenCalledWith({ id: 'uuid-v4', name: 'push', payload: { commits: [] } });
  });

  test('that failures are handled', async () => {
    probot.receive = jest.fn(async () => {
      throw new Error('oh noes');
    });
    await expect(adapt(() => {})).rejects.toThrow('oh noes');
    expect(core.setFailed).toHaveBeenCalledWith('Action failed with error: oh noes');
  });
});